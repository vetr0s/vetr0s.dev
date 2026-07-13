---
title: "Colophon"
---

The tools, themes, and influences behind this site.

## Built with

- [Hugo](https://gohugo.io/): static site generator
- Hand-written templates and CSS — no theme, no framework, no JavaScript beyond a theme toggle
- Built and deployed to [GitHub Pages](https://pages.github.com/) by [GitHub Actions](https://github.com/features/actions) on every push to `main`

## Typography

The site loads **no web fonts**. Every typeface here is one your machine already has, so text renders on the first paint: nothing extra to download, and no flash of a fallback font swapping itself out a moment later.

- Body and headings: the system sans (`system-ui`), falling back through `-apple-system`, `Segoe UI`, and `Noto Sans`
- Code: the system mono (`ui-monospace`), falling back through `Hack` and `DejaVu Sans Mono`

Headings are set semibold on a 1.2 modular scale, one step down from the sizes a browser would pick on its own. The body runs about `20px` at every width: no step up on large screens, because the point is a page that reads like a document rather than a poster.

That size is set once, at the root. Every length here is font-relative — the measure and the column in `ch`, the spacing in `rem` — so a single number scales the whole layout the way your browser's zoom does, and the page is simply shipped at the size it was being read at anyway.

Body text is set a half step above regular. White on black reads thinner than black on white at the same weight, and the leading is kept tight for the same reason: spread the same ink over more page and a paragraph turns into a grey field instead of a block of white.

## Layout

The page hugs the left margin and stops at its measure. Nothing is centered — a centered column asks your eye to find the text; a left-aligned one puts it where the eye already is.

Prose is held to a `90ch` measure inside a `110ch` column. The difference between the two is the gutter, which is where margin notes live: a note floats to the right edge of the column, so it sits mostly *beside* the prose rather than carving a third out of it, and only the tail of each line tucks around it. On a screen too narrow to spare a gutter, notes drop back into the flow as bordered blocks.

Photographs stay out of the gutter. A picture wide enough to see is taller than the two or three paragraphs it would sit beside, so it hangs past the end of them and leaves the section standing on empty space. In the flow instead, capped well short of the measure and placed after the passage it illustrates, it interrupts the prose without becoming the page. The gutter is for notes, which are short by nature.

## Colors

The light and dark color schemes are based on the [Modus themes](https://protesilaos.com/emacs/modus-themes-colors) by Protesilaos Stavrou:

- `modus-operandi`: light
- `modus-vivendi`: dark

Headings use the `yellow-warmer`, `magenta`, and `cyan` accents from the same palettes, and syntax highlighting is drawn from the same set, so a code block is tinted like the rest of the page instead of carrying a theme of its own. Both schemes follow your system preference by default; the toggle overrides it, and the choice persists in `localStorage`.

## Design influence

- [andrewkelley.me](https://andrewkelley.me/): the plainness. Left-aligned, underlined links, a document rather than a layout
- [protesilaos.com](https://protesilaos.com/): system-font text on a modular scale, with no web fonts, and the Modus palettes above
- [gingerbill.org](https://www.gingerbill.org/): the inline-list nav with `|` separators is borrowed from Bill's site
- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the margin note, set beside the passage that introduces it rather than collected in a sidebar at the end

## Navigation

The home page carries the full banner. Everywhere else — posts, projects, this page — the banner would be furniture in front of the thing you came to read, so it is replaced by a single line: where you are, and a link back out of it.
