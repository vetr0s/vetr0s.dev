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

Prose is held to an `80ch` measure, and that measure is the whole column. There is no gutter beside it, because there is nothing left to put there.

Asides used to float into that gutter as margin notes. They read well one at a time and badly in a run: a note beside a paragraph is a second thing to look at while you are still reading the first, and the eye takes the offer. Now an aside is a footnote. A small muted number marks the claim, the note waits under a rule at the end of the page, and the line you are reading runs its full width from the first word to the last. The marker links both ways, so the trip out and back is one click each.

Notes are set smaller and muted, and links inside them keep the underline without the color. A footnote list is apparatus, and it should read as the end of the page rather than as more page.

Photographs sit in the flow, capped well short of the measure and placed after the passage they illustrate, so a picture interrupts the prose without becoming the page.

## Colors

The light and dark color schemes are based on the [Modus themes](https://protesilaos.com/emacs/modus-themes-colors) by Protesilaos Stavrou:

- `modus-operandi`: light
- `modus-vivendi`: dark

Headings use the `yellow-warmer`, `magenta`, and `cyan` accents from the same palettes, and syntax highlighting is drawn from the same set, so a code block is tinted like the rest of the page instead of carrying a theme of its own. Both schemes follow your system preference by default; the toggle overrides it, and the choice persists in `localStorage`.

## Design influence

- [andrewkelley.me](https://andrewkelley.me/): the plainness. Left-aligned, underlined links, a document rather than a layout
- [protesilaos.com](https://protesilaos.com/): system-font text on a modular scale, with no web fonts, and the Modus palettes above
- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the aside written where the claim is, rather than collected in a sidebar at the end. Set as a footnote here instead of a margin note

## Navigation

Every page opens the same way: one line saying where you are, and a link back out of it. There is no menu and no banner, because a menu on every page is furniture standing in front of the thing you came to read, and a banner on the home page is the same furniture with a bigger typeface.

That makes the home page the way in. It carries the contact details, a short list of everywhere else on the site, and the most recent posts, and it is one click from anywhere: a post climbs to its section, a section climbs home, and home has the rest.

The about page used to live on the home page inside collapsible sections, which existed only to keep that page from running long. A page of its own does the same job without asking you to open anything.
