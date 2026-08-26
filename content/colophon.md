---
title: "Colophon"
---

The tools, themes, and influences behind this site.

## Built with

- [pandoc](https://pandoc.org/) and `make`.[^pandoc-make] The page shapes are pandoc
  templates. What a template cannot express is a Lua filter
- Hand-written CSS. No theme, no framework, no JavaScript beyond a theme toggle
- Built by hand and committed, then served from `main:/docs` by [GitHub
  Pages](https://pages.github.com/)
- An [RSS feed](/index.xml) of the posts

[^pandoc-make]: Pandoc turns Markdown into HTML. Make records which source files
    each output needs and rebuilds the affected files.

The site's identity lives in one `site.yaml`: title, base URL, author, locale,
and the brand split. The front-page introduction lives in `content/_index.md`.
Project metadata selects the work shown below it. Recent posts appear only when
there is something published. Changing the shape of a page means editing an HTML
file rather than recompiling anything.

Until August 2026 this site was built by [ostat](/projects/ostat/), a static
site generator I wrote in [Odin](https://odin-lang.org/). It was an experiment
in owning the whole pipeline, and as an experiment it worked. Keeping it was the
part that stopped making sense. A compiler checking the whole site is worth
little at six pages, and rebuilding that compiler to move a heading is worth a
lot of friction. ostat is archived now.

## Typography

The site is set in [ET Book](https://edwardtufte.github.io/et-book/),[^et-book] the
typeface from Edward Tufte's books, served from this domain in three cuts:
roman, bold, and display italic.

[^et-book]: ET Book is a free digitization of the Bembo-style typeface used in
    many of Tufte's books.

This is a change. The site used to load no web fonts at all and set everything
in `system-ui`. Serving a face costs a download that a system font does not, so
the roman cut is preloaded during HTML parse and is ready by first paint.
`font-display` is `optional`, which means a cold first visit renders in Palatino
rather than waiting on the network or swapping the text out mid-read.

- Body and headings: ET Book, falling back to Palatino and then Georgia
- Code: `ui-monospace`, then `Hack`, `DejaVu Sans Mono`

Headings run on a 1.15 modular scale, anchored to the body size so that none of
them sets smaller than the prose. The body runs `1.25rem` at every width, with
no step up on large screens. The page should read like a document, not a
poster.

The sheet and spacing use `rem`, so browser zoom scales the whole layout.

## Layout

The page is a `60rem` sheet centered in the window, with a band of the page
showing at either side. Text stays left aligned and uses the sheet's full inner
width.

This used to be the other way around. The page hugged the left margin and
nothing was centered at all, on the argument that a centered column asks your
eye to find the text while a left-aligned one puts it where the eye already is.
That argument holds on a narrow window. On a wide one it strands the sheet
against one edge and leaves the rest of the display reading as spill. Centering
the sheet gives the text an edge and puts the page where the eye expects it.

An aside is an inline disclosure. A small number marks the claim. Activating it
opens the note below the sentence. The behavior does not change with window
width. Notes are smaller and muted. Their markers and links use a dimmed form of
the link color.

Photographs sit in the flow. Each one is capped well short of the page and
placed after the passage it illustrates. A picture interrupts the prose without
becoming the page.

## Colors

The light and dark color schemes are based on the [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors) by Protesilaos
Stavrou:

- `modus-operandi`: light
- `modus-vivendi`: dark

The sheet is divided from the page behind it by one step of tone and a hairline
rule. Light dims the page away from a white sheet. Dark cannot dim below black,
so it does the reverse and lifts the sheet off a page that takes the black. The
rule is what actually reads as the edge, which lets both tones stay quiet.

Headings use the `yellow-warmer`, `magenta`, and `cyan` accents from the same
palettes. Syntax highlighting is drawn from the same set. A code block is tinted
like the rest of the page instead of carrying a theme of its own.

Highlighting is pandoc's, which lexes about two hundred languages
properly.[^lexer] Its token names are translated to the Chroma names the
stylesheet already carried, so the palette above is what colors the code. A
token the stylesheet has no rule for is left unclassed rather than given a color
it never chose.

[^lexer]: A lexer identifies parts of source code such as keywords, strings,
    and comments. The stylesheet assigns colors to those categories.

Both schemes follow your system preference by default. The toggle overrides it.
The choice persists in `localStorage`.

## Design influence

- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the typeface and the
  original note treatment
- [gingerBill.org](https://github.com/gingerBill/gingerBill.org): the note
  markup and the case for a site you assemble yourself
- [andrewkelley.me](https://andrewkelley.me/): the plainness. Left-aligned,
  underlined links, a document rather than a layout
- [protesilaos.com](https://protesilaos.com/): the Modus palettes above

## Navigation

Every page opens the same way. One line says where you are and links back out of
it. There is no menu and no banner. A menu on every page is furniture standing
in front of the thing you came to read. A banner on the home page is the same
furniture in a bigger typeface.

That makes the home page the way in. It carries an introduction, projects,
contact details, and a short list of everywhere else. Recent posts appear when
there are published posts to list. A post climbs to its section. A section
climbs home. Home has the rest.

## The feed

[`/index.xml`](/index.xml) carries the posts.
[`/articles/index.xml`](/articles/index.xml) carries the same ones, so either address
works in a reader.

An item carries the whole post rather than an excerpt. A feed has no margin and
no stylesheet, so each post is rendered a second time with its notes as numbered
endnotes and every anchor absolute. Nothing here asks you to click through to
finish reading.
