#!/usr/bin/env python3

from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urlsplit
import sys
import xml.etree.ElementTree as ET


class PageParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.canonical = []
        self.references = []
        self.external_targets = []
        self.sidenote_inputs = []
        self.nodes = []

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        self.nodes.append((tag, attrs))
        if tag == "link" and attrs.get("rel") == "canonical":
            self.canonical.append(attrs.get("href"))
        for name in ("href", "src"):
            value = attrs.get(name)
            if value:
                self.references.append(value)
        href = attrs.get("href", "")
        if href.startswith(("http://", "https://")) and attrs.get("target"):
            self.external_targets.append(href)
        if tag == "input" and "margin-toggle" in attrs.get("class", "").split():
            self.sidenote_inputs.append(attrs)


def target_path(root, value):
    path = urlsplit(value).path
    if path == "/":
        return root / "index.html"
    candidate = root / path.lstrip("/")
    if path.endswith("/"):
        return candidate / "index.html"
    return candidate


def fail(message):
    print(message, file=sys.stderr)
    raise SystemExit(1)


root = Path(sys.argv[1])
required = [
    "index.html",
    "about/index.html",
    "projects/mach/index.html",
    "projects/gaterelay/index.html",
    "projects/difr/index.html",
    "projects/tucson-crime-analysis/index.html",
    "index.xml",
    "blog/index.xml",
    "sitemap.xml",
]
for relative in required:
    if not (root / relative).is_file():
        fail(f"missing output: {relative}")

for xml in ("index.xml", "blog/index.xml", "sitemap.xml"):
    ET.parse(root / xml)

for page in root.rglob("*.html"):
    parser = PageParser()
    parser.feed(page.read_text(encoding="utf-8"))
    if len(parser.canonical) != 1:
        fail(f"{page}: expected one canonical link")
    if parser.external_targets:
        fail(f"{page}: external links force a new tab")
    for attrs in parser.sidenote_inputs:
        if not attrs.get("aria-label") or not attrs.get("aria-controls"):
            fail(f"{page}: unnamed sidenote control")
        position = parser.nodes.index(("input", attrs))
        if position + 2 >= len(parser.nodes):
            fail(f"{page}: incomplete sidenote markup")
        label, note = parser.nodes[position + 1 : position + 3]
        if label[0] != "label" or note[0] != "span":
            fail(f"{page}: sidenote controls are not adjacent")
        if label[1].get("for") != attrs.get("id"):
            fail(f"{page}: sidenote label targets the wrong control")
        if note[1].get("id") != attrs.get("aria-controls"):
            fail(f"{page}: sidenote controls target the wrong note")
    for reference in parser.references:
        if not reference.startswith("/") or reference.startswith("//"):
            continue
        if not target_path(root, reference).exists():
            fail(f"{page}: broken local reference {reference}")

home = (root / "index.html").read_text(encoding="utf-8")
if ">Projects<" not in home:
    fail("home page has no projects section")
if "Recent Articles" in home:
    fail("home page promotes an empty articles section")
if ">Articles<" not in home:
    fail("home page has no articles section")
for tag in ("programming", "web", "tools"):
    if f"<li>{tag}</li>" not in home:
        fail(f"home page is missing article tag: {tag}")
title_at = home.index("<h1>Nathan Tebbs</h1>")
contact_at = home.index('class="contact-panel"')
intro_at = home.index("<p>I am a software engineer")
if not title_at < contact_at < intro_at:
    fail("home identity content is in the wrong order")
if "Find Me" in home or 'id="find-me"' in home:
    fail("home page still has a Find Me section")

article = root / "blog/static-site-generator-hell/index.html"
article_html = article.read_text(encoding="utf-8")
if article_html.count('<pre><code class="chroma language-') < 2:
    fail("published article is missing its code examples")
if 'class="article-hero"' not in article_html:
    fail("published article is missing its header image")
if 'content="https://vetr0s.dev/static-site-generator-hell.png"' not in article_html:
    fail("published article is missing image metadata")

css = (root / "css/style.css").read_text(encoding="utf-8")
if "figure img { height: auto; }" not in css:
    fail("figure images do not preserve their aspect ratio")
for stale in (
    "--measure",
    "--layout-width",
    "--sidenote-width",
    "--sidenote-gap",
    "max-width: 63em",
    "float: right",
):
    if stale in css:
        fail(f"stale gutter rule remains: {stale}")
if ".sidenote {\n    display: none;" not in css:
    fail("notes are not collapsed at every width")
if "@media (max-width: 32em)" not in css or "grid-template-columns: 1fr;" not in css:
    fail("contact details do not stack on narrow screens")

print(f"checked {sum(1 for _ in root.rglob('*.html'))} pages")
