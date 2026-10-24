---
title: Colophon
date: 2026-09-18
updated: 2026-10-23
update_note: Rewritten for the switch from Org Publish to swag.
description: How this website is written and built.
---

This website is written in Markdown in neovim and built into plain HTML by [swag](https://github.com/vetr0s/swag), a small static site generator I wrote in Go. Pandoc renders the Markdown and highlights the code. A small CSS file handles the presentation, and the pages use system fonts. There is no client-side JavaScript.

Posts and pages live in `content/`, the page templates in `layouts/`, and static assets in `static/`. swag writes the finished site to `docs/`, which GitHub Pages serves. I describe the setup in [Adding swag to my zero-dependency static website generator](adding-swag-to-my-zero-dependency-static-website-generator.html). The Emacs and Org setup it replaced is in [A zero-dependency static website generator](zero-dependency-static-site-generator.html).

The site intentionally has no analytics, tracking, comments, or cookie banner. You can follow new posts through [RSS](https://vetr0s.dev/rss.xml) or reach me at <nate@vetr0s.dev>.
