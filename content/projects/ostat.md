---
{
    "title": "ostat",
    "description": "A static site generator written in Odin. Layouts are procedures, not templates. It builds this site."
}
---

A static site generator written in [Odin](https://odin-lang.org/), modeled
after the generator behind
[gingerBill.org](https://github.com/gingerBill/gingerBill.org). It builds this
site, and its own [documentation](https://ostat.vetr0s.dev/).

- [Source](https://github.com/vetr0s/ostat)
- [Documentation](https://ostat.vetr0s.dev/)
- [Releases](https://github.com/vetr0s/ostat/releases)

## What it does

Markdown in, a directory of HTML out. A file named `_index.md` is its
directory's section page and any other `.md` file is a regular page, so the
URL structure is the content structure. A build also writes `sitemap.xml`, a
404 page, and two RSS feeds carrying the same items, so either address works in
a reader.

Beyond that it does the small number of things these two sites actually needed:
margin notes in the Tufte style, syntax highlighting, tables, a summary lifted
from a page's opening paragraph when the front matter does not give one, and
dates that may carry a time so two posts published on one day have an order.

## What it does not do

There is no template language. Every layout is a procedure that writes HTML
with `write_string` and `sbprintf`, which means no partials to thread and no
syntax to learn, and it means moving a heading is a recompile rather than an
edit. That is the trade, made deliberately[^trade].

[^trade]: The compiler checks the whole thing, which a template language cannot
    do. Whether that is worth a recompile depends entirely on how often you move
    headings.

There is no theme system and no plugin API. A site brings a `site.json` holding
its identity, an `html/` directory holding its front page, its 404, and the two
halves of its `<head>`, and its content. Those are documents, so they are
stored as documents. Everything about the shape of a page lives in the
generator.

## Why write one

Hugo built this site before ostat did, and it worked. It is also a large Go
program behind a template language and a theme system, in service of eight
pages of HTML I could describe exactly. Writing the generator meant the whole
pipeline from markdown to bytes on disk fits in my head, and every decision in
it is one I made rather than one I configured around.

Odin because I wanted to write something real in it, and because a generator is
a good fit for a language with arena allocation: a build is a batch job with a
clear end, so two arenas and no frees is the whole memory strategy.

## Where it is

At [0.5.0](https://github.com/vetr0s/ostat/releases), and about three thousand
lines of Odin.

It is pinned by a fixture site and a committed tree of its expected output, so
a change that alters any page of any shape the fixture covers shows up as a
diff to read rather than as a surprise later. That, plus a hundred-odd unit
tests for the parts a document comparison cannot reach.

It is used by exactly two sites, both of them mine, which is the correct number
for software of this age.
