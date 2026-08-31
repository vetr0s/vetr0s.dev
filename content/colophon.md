---
title: "Colophon"
---

The design lineage and publishing system behind this site.

## Ginger Bill

This site would not look like this without [Ginger Bill's
website](https://www.gingerbill.org/). I have returned to it for years as an
example of what a personal technical site can be. Its influence reaches past the
typeface and margin notes. The page geometry here starts with his. So do the
large headings, section-sign links, bordered code blocks, and the way notes move
beside the article on a wide screen.

His influence also changed how I built the site. My old static-site generator,
[ostat](/projects/ostat/), began as an Odin take on the generator behind
gingerBill.org. The current site uses pandoc and Make, but I kept the same goal. I
want the publishing system to stay small enough that I can understand and change
the whole thing. The [gingerBill.org source
repository](https://github.com/gingerBill/gingerBill.org) made that approach
concrete for me.

That debt deserves clear credit. Ginger Bill is the strongest direct design
influence on this site. [Tufte CSS](https://edwardtufte.github.io/tufte-css/) is
the earlier source for ET Book and the original sidenote pattern. The light and
dark colors come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors).

## What I carried over

The current layout uses the same core proportions as gingerBill.org. The body
takes `87.5%` of the viewport with `12.5%` of left padding. The sheet stops
growing at `80rem`. The article uses `60%` of that width and leaves the rest for
margin notes.

ET Book sets the body and headings. The body stays at `1.25rem`. Large neutral
headings divide the document by size and rules rather than by color. Links on
second- and third-level headings reveal a section sign in the margin when
hovered.

Notes float beside the article on a wide screen. Below the `80rem` breakpoint,
the article fills the available width and each note collapses behind its number.
The same checkbox and label markup supports both layouts without JavaScript.

Inline code and code blocks sit on a bordered surface. That treatment also
started with gingerBill.org. Tables use the same surface for alternating rows,
with an outer border and rules between columns.

## What changed here

The page and sheet share one background. One blue accent marks links, the
wordmark, note numbers, the theme toggle, and heading self-links. The rest of the
light and dark colors follow the Modus Operandi and Modus Vivendi palettes.
Syntax highlighting uses colors from the same palettes.

The breadcrumb, header rule, contact panel, project listings, table treatment,
and feeds belong to this site. The stylesheet now lives in its own
[vetr0s.css repository](https://github.com/vetr0s/vetr0s.css). Its [specimen
page](https://css.vetr0s.dev/) renders every selector in both themes. This site
keeps a local copy so each build remains self-contained.

## Built with

- [pandoc](https://pandoc.org/) turns Markdown into HTML
- GNU Make records dependencies and builds the site
- HTML templates hold page structure
- Lua filters handle notes, code highlighting, listings, dates, and page metadata
- Hand-written CSS controls the presentation
- One small script stores the light or dark theme choice
- [GitHub Pages](https://pages.github.com/) serves the committed `docs/` tree
- An [RSS feed](/index.xml) carries article descriptions and links

The site's identity lives in `site.yaml`. Content lives under `content/`.
Templates live under `templates/`. The canonical stylesheet can be copied from
the sibling repository with `make sync-css`. A production build validates the
generated links, markup, metadata, and required pages before replacing `docs/`.

Until August 2026, ostat built this site. It reached about three thousand lines
and more than a hundred tests. It worked, and it taught me Odin and static-site
architecture. Maintaining the generator eventually displaced the writing, so I
replaced it with pandoc and Make and archived the project.

## Navigation and feeds

Every page starts with a breadcrumb. A post links to its section. A section links
home. The home page points to recent articles, featured projects, contact
details, and the complete section indexes.

[`/index.xml`](/index.xml) and
[`/articles/index.xml`](/articles/index.xml) carry the same articles. Each item
contains the article description and links to the canonical post.
