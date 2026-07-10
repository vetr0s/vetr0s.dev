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

Headings are set bold on a 1.2 modular scale. The root font size steps from `100%` up to `125%` on viewports wider than `75em`, so the whole type system scales together rather than the body text alone.

## Colors

The light and dark color schemes are based on the [Modus themes](https://protesilaos.com/emacs/modus-themes-colors) by Protesilaos Stavrou:

- `modus-operandi`: light
- `modus-vivendi`: dark

Headings use the `yellow-warmer`, `magenta`, and `cyan` accents from the same palettes. Both schemes follow your system preference by default; the toggle in the nav overrides it, and the choice persists in `localStorage`.

## Design influence

- [protesilaos.com](https://protesilaos.com/): the typography here — large, bold, system-font text on a modular scale, with no web fonts — follows Prot's site, as do the Modus palettes above
- [gingerbill.org](https://www.gingerbill.org/): the inline-list nav with `|` separators is borrowed from Bill's site
- [Tufte CSS](https://edwardtufte.github.io/tufte-css/): the dedicated right-hand gutter for asides and margin notes is inspired by Tufte's layout
