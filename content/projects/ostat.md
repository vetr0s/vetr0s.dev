---
title: "ostat"
description: "A static site generator written in Odin. An experiment in building the whole pipeline myself. Archived."
status: "Archived"
---

A static site generator written in [Odin](https://odin-lang.org/), modeled
after the generator behind
[gingerBill.org](https://github.com/gingerBill/gingerBill.org). It built this
site until August 2026.

It is archived. The source is still up, the documentation site is gone, and
nothing runs it any more.

- [Source](https://github.com/vetr0s/ostat)
- [Releases](https://github.com/vetr0s/ostat/releases)

## What it did

Markdown in, a directory of HTML out. A file named `_index.md` was its
directory's section page and any other `.md` file was a regular page, so the
URL structure was the content structure. A build also wrote `sitemap.xml`, a
404 page, and two RSS feeds carrying the same items, so either address worked in
a reader.

Beyond that it did the small number of things this site actually needed: margin
notes in the Tufte style, syntax highlighting, tables, a summary lifted from a
page's opening paragraph when the front matter did not give one, and dates that
could carry a time so two posts published on one day had an order.

It reached [0.5.0](https://github.com/vetr0s/ostat/releases) at about three
thousand lines, pinned by a fixture site, a committed tree of its expected
output, and a hundred-odd unit tests.

## What it did not do

There was no template language. Every layout was a procedure that wrote HTML
with `write_string` and `sbprintf`, which meant no partials to thread and no
syntax to learn, and it meant moving a heading was a recompile rather than an
edit. That was the trade, made deliberately[^trade].

[^trade]: The compiler checks the whole thing, which a template language cannot
    do. Whether that is worth a recompile depends entirely on how often you move
    headings.

There was no theme system and no plugin API. Everything about the shape of a
page lived in the generator.

## Why I wrote it

Hugo built this site before ostat did, and it worked. It is also a large Go
program behind a template language and a theme system, in service of eight pages
of HTML I could describe exactly. Writing the generator meant the whole pipeline
from markdown to bytes on disk fit in my head, and every decision in it was one
I made rather than one I configured around.

Odin because I wanted to write something real in it, and because a generator is
a good fit for a language with arena allocation: a build is a batch job with a
clear end, so two arenas and no frees is the whole memory strategy.

## Why I stopped

The trade stopped paying. A compiler checking the whole site is worth very
little at six pages, and rebuilding that compiler to move a heading is worth a
lot of friction. I had written more generator than site, which is the wrong way
round for something whose point is the writing.

So the site moved to pandoc and a Makefile, and ostat stopped being load
bearing. The [colophon](/colophon/) covers what replaced it.

I do not regret writing it. Learning Odin properly and owning the whole path
from markdown to bytes was the point, and both happened. Keeping it alive to
serve one site afterward was not.
