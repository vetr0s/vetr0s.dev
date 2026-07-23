---
title: "Colophon"
---

The tools, themes, and influences behind this site.

## Built with

- [Hugo](https://gohugo.io/): static site generator
- Hand-written templates and CSS. No theme, no framework, no JavaScript beyond a theme toggle
- Built and deployed to [GitHub Pages](https://pages.github.com/) by [GitHub Actions](https://github.com/features/actions) on every push to `main`

## Typography

The site loads **no web fonts**. Every typeface here is one your machine already has. Text renders on the first paint. Nothing extra downloads, and no fallback font swaps itself out a moment later.

- Body and headings: `system-ui`, then `-apple-system`, `Segoe UI`, `Noto Sans`
- Code: `ui-monospace`, then `Hack`, `DejaVu Sans Mono`

Headings are set semibold on a 1.2 modular scale. That is one step down from the sizes a browser picks on its own.

The body runs about `20px` at every width. There is no step up on large screens. The page should read like a document, not a poster.

That size is set once, at the root. Every length here is font-relative. The measure is in `ch` and the spacing is in `rem`. One number scales the whole layout the way your browser's zoom does. The page ships at the size it was being read at.

Body text is set a half step above regular. White on black reads thinner than black on white at the same weight. The leading is kept tight for the same reason. Spread the same ink over more page and a paragraph turns into a grey field instead of a block of white.

## Layout

The page hugs the left margin and stops at its measure. Nothing is centered. A centered column asks your eye to find the text. A left-aligned one puts it where the eye already is.

Prose is held to an `80ch` measure. That measure is the whole column. There is no gutter beside it. Nothing is left to put there.

Asides used to float into that gutter as margin notes. They read well one at a time and badly in a run. A note beside a paragraph is a second thing to look at while you are still reading the first. The eye takes the offer.

Now an aside is a footnote. A small muted number marks the claim. The note waits under a rule at the end of the page. The line you are reading runs its full width from the first word to the last. The marker links both ways. The trip out and back is one click each.

Notes are set smaller and muted. Links inside them keep the underline without the color. A footnote list is apparatus. It should read as the end of the page, not as more page.

Photographs sit in the flow. Each one is capped well short of the measure and placed after the passage it illustrates. A picture interrupts the prose without becoming the page.

## Colors

The light and dark color schemes are based on the [Modus themes](https://protesilaos.com/emacs/modus-themes-colors) by Protesilaos Stavrou:

- `modus-operandi`: light
- `modus-vivendi`: dark

Headings use the `yellow-warmer`, `magenta`, and `cyan` accents from the same palettes. Syntax highlighting is drawn from the same set. A code block is tinted like the rest of the page instead of carrying a theme of its own.

Both schemes follow your system preference by default. The toggle overrides it. The choice persists in `localStorage`.

## Design influence

- [andrewkelley.me](https://andrewkelley.me/): the plainness. Left-aligned, underlined links, a document rather than a layout
- [protesilaos.com](https://protesilaos.com/): system-font text on a modular scale, no web fonts, and the Modus palettes above
- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the aside written where the claim is, rather than collected in a sidebar at the end. Set as a footnote here instead of a margin note

## Navigation

Every page opens the same way. One line says where you are and links back out of it. There is no menu and no banner. A menu on every page is furniture standing in front of the thing you came to read. A banner on the home page is the same furniture in a bigger typeface.

That makes the home page the way in. It carries the contact details, a short list of everywhere else, and the most recent posts. It is one click from anywhere. A post climbs to its section. A section climbs home. Home has the rest.

The about page used to live on the home page inside collapsible sections. Those existed only to keep the home page from running long. A page of its own does the same job. Nothing needs opening.
