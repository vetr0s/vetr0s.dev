# vetr0s.dev

My personal site. Some writing, a few projects, and a page about who I am. It is
built by [pandoc](https://pandoc.org/) and `make`. The page shapes are pandoc
templates and the transformations pandoc cannot express are Lua filters. It
ships one small script for the light/dark toggle.

## Running it

```bash
make                  # build with drafts, into public/
make serve            # the same, then serve on localhost:1313
make build            # the published build, into docs/
make clean            # discard both output trees
make new              # prompt for a post title
```

`PORT` overrides the port. `V=1` prints each pandoc command line instead of a
label, which is what you want when a page comes out wrong and you need to see
what produced it. The only requirement is pandoc 3 and `python3` for
`make serve`.

Every target says what it wrote. A rebuild after one edit prints only the pages
that actually changed, which is the quickest way to see whether make agrees with
you about what depends on what.

There is no file watcher and no live reload. A whole build takes about two
seconds, so rebuilding is ctrl-c and rerun.

`public/` is the local preview and is not committed. The published tree is
`docs/`, which is committed: GitHub Pages serves `main:/docs` with its own
builder. Publishing is `make build`, then commit `docs/` and push.

## How it's laid out

| Path | What lives there |
|---|---|
| `site.yaml` | The site's identity: title, base URL, description, author, locale, the brand split. Everything is nested under `site:` so nothing collides with a page's own front matter |
| `templates/` | The page shapes. `head.html` and `crumbs.html` are partials the rest pull in |
| `lua/` | The filters. Anything a template cannot express lives here |
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `about.md`, `colophon.md` and `404.md` |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/font/` | ET Book, three cuts, served from this domain |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons, images, `CNAME`, and `resume.pdf` |

Changing the shape of a page means editing an HTML file in `templates/`.
Changing what a page knows about itself means editing `lua/page.lua`.

`content/_index.md` holds the front-page introduction. `templates/home.html`
adds featured projects from project front matter and recent posts when any are
published.

## Writing a post

```bash
make new
```

The command prompts for the title.

Every post starts as a draft. Front matter is YAML.

```markdown
---
title: "Some Post"
date: 2026-07-12
draft: true
tags:
  - programming
  - tools
---
```

| Field | Notes |
|---|---|
| `title` | Required |
| `date` | Rendered under the title. Required for a post under `blog/`. May carry a time, so a day can hold two posts |
| `description` | Used for the meta description and for the summary line in a section listing. Falls back to the opening paragraph for the meta tag only |
| `draft` | `true` keeps it out of `make build`. `make` shows it anyway |
| `tags` | A YAML list used beneath article titles. Keep each tag short and lowercase |

The filename owns the URL. Rename the file before publishing if the generated
slug is not the address you want.

## Asides

An aside is an inline disclosure, written as a standard Markdown footnote. The
marker stays in the sentence and the definition may live anywhere in the file.

```markdown
The page uses one reading column.[^column]

[^column]: Notes wait behind their numbered markers until the reader opens them.
```

The generator emits no numbers. The visible number comes from a CSS counter, so
the marker and its note cannot drift apart. The same disclosure works at every
window width.

Note ids are `sn-1`, `sn-2`, numbered by first appearance. Pandoc's reader
discards the label before a filter can see it, and the id only binds a label to
its checkbox inside one page, so the number is enough. A second reference to one
note emits only the marker and points at the note the first one wrote.

A definition that nothing references fails the build, which is how a mistyped
label gets caught. An unresolved `[^` in prose is left alone, because `[^` is
ordinary text more often than it is a note.

## The feed

`/index.xml` and `/articles/index.xml` are the same document, differing only in the
address each advertises as its own. Both carry blog posts and nothing else, and
both are linked from the head. Each is linked from an `.rss-badge` beside the
heading of the list it feeds. Only a section that publishes a feed draws the
badge, so the projects page has none.

Each item carries the article description and links to the canonical post.

## The look

Set in [ET Book](https://edwardtufte.github.io/et-book/), left aligned inside a
`60rem` sheet centered in the window. Text fills the sheet's inner width. Colors
come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors), `modus-operandi` for
light and `modus-vivendi` for dark, and they carry through to syntax
highlighting.

Syntax highlighting is pandoc's, remapped to the Chroma class names the
stylesheet already carried. `lua/code.lua` holds that mapping. Code follows the
theme rather than shipping one of its own.

Every page opens on the same breadcrumb line with the theme toggle beside it. A
post reads `vetr0s.dev / blog`. Home is just the wordmark. There is no menu.

More of that, including what changed and why, is written up at
[vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
