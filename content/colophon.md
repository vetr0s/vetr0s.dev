---
{
    "title": "Colophon"
}
---

The tools, themes, and influences behind this site.

## Built with

- [ostat](https://github.com/vetr0s/ostat): a static site generator I wrote in
  [Odin](https://odin-lang.org/). There is no template language. Every layout
  is a procedure that writes HTML
- Hand-written CSS. No theme, no framework, no JavaScript beyond a theme toggle
- Built and deployed to [GitHub Pages](https://pages.github.com/) by [GitHub
  Actions](https://github.com/features/actions) on every push to `main`
- An [RSS feed](/index.xml) of the posts

The site's identity lives in one `site.json`: title, base URL, author, locale,
and the brand split. The front page lives in `html/home.html` and is ordinary
markup, with one marker saying where the recent posts go. Everything else about
the shape of a page is a procedure in the generator.

## Typography

The site is set in [ET Book](https://edwardtufte.github.io/et-book/), the
typeface from Edward Tufte's books, served from this domain in three cuts:
roman, bold, and display italic.

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

Every length is font-relative. The measure is in `ch` and the spacing is in
`rem`, so one number at the root scales the whole layout the way your browser's
zoom does.

## Layout

The page is a sheet, centered in the window, with a band of the page showing at
either side. Inside it nothing is centered: the text is left aligned and stops
at its measure, the way it always was.

This used to be the other way around. The page hugged the left margin and
nothing was centered at all, on the argument that a centered column asks your
eye to find the text while a left-aligned one puts it where the eye already is.
That argument holds on a narrow window. On a wide one it strands the column
against one edge and leaves the rest of the display reading as spill. Centering
the sheet rather than the text keeps both: the column has an edge to sit
against, and the eye still lands on the first word.

Prose is held to a `68ch` measure, and beside it there is a gutter.

An aside is a margin note. A small number marks the claim, and the note itself
sits in the gutter beside it, at the height of the line that raised it. No
click, no jump to the bottom of the page, and no trip back.

This is the second time these have changed. They began as margin notes, became
footnotes collected under a rule at the end, and are margin notes again. The
argument for footnotes was that a note beside a paragraph is a second thing to
look at while you are still reading the first. The argument against was that the
trip to the bottom of the page and back costs more attention than the glance
ever did.

Below about `63em` of window there is no room for a gutter. The note folds: the
marker becomes a toggle, and tapping it opens the note inline underneath.
Nothing is lost on a phone. It waits to be asked for.

Notes are set smaller and muted. Links inside them keep the underline without
the color. A note is apparatus. It should read as a gloss on the page rather
than as more page.

Photographs sit in the flow. Each one is capped well short of the measure and
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

Highlighting is done by the generator rather than by a library. It is a keyword
table and a scanner, not a parser, and it produces only the seven token groups
the stylesheet distinguishes.

Both schemes follow your system preference by default. The toggle overrides it.
The choice persists in `localStorage`.

## Design influence

- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the margin note, and
  the typeface
- [gingerBill.org](https://github.com/gingerBill/gingerBill.org): the generator
  ostat is modeled on, layouts as procedures rather than templates
- [andrewkelley.me](https://andrewkelley.me/): the plainness. Left-aligned,
  underlined links, a document rather than a layout
- [protesilaos.com](https://protesilaos.com/): the Modus palettes above

## Navigation

Every page opens the same way. One line says where you are and links back out of
it. There is no menu and no banner. A menu on every page is furniture standing
in front of the thing you came to read. A banner on the home page is the same
furniture in a bigger typeface.

That makes the home page the way in. It carries where to find me, a short list
of everywhere else, and the most recent posts. It is one click from anywhere. A
post climbs to its section. A section climbs home. Home has the rest.

## The feed

[`/index.xml`](/index.xml) carries the posts.
[`/blog/index.xml`](/blog/index.xml) carries the same ones, so either address
works in a reader.

An item carries the whole post rather than an excerpt. A feed has no margin and
no stylesheet, so each post is rendered a second time with its notes as numbered
endnotes and every anchor absolute. Nothing here asks you to click through to
finish reading.
