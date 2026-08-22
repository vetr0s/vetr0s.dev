# vetr0s.dev

My personal site. Some writing, a few projects, and a page about who I am. It is
built by [pandoc](https://pandoc.org/) and `make`. The page shapes are pandoc
templates and the transformations pandoc cannot express are Lua filters. It
ships one small script for the light/dark toggle.

## Running it

```bash
make                  # build with drafts, into public/
make serve            # the same, then serve on localhost:1313
make build            # the published build, into docs/
make clean            # discard both output trees
make new t="A Title"  # start a post under content/blog/
```

`PORT` overrides the port. `V=1` prints each pandoc command line instead of a
label, which is what you want when a page comes out wrong and you need to see
what produced it. The only requirement is pandoc 3 and `python3` for
`make serve`.

Every target says what it wrote. A rebuild after one edit prints only the pages
that actually changed, which is the quickest way to see whether make agrees with
you about what depends on what.

There is no file watcher and no live reload. A whole build takes about two
seconds, so rebuilding is ctrl-c and rerun.

`public/` is the local preview and is not committed. The published tree is
`docs/`, which is committed: GitHub Pages serves `main:/docs` with its own
builder. Publishing is `make build`, then commit `docs/` and push.

## How it's laid out

| Path | What lives there |
|---|---|
| `site.yaml` | The site's identity: title, base URL, description, author, locale, the brand split. Everything is nested under `site:` so nothing collides with a page's own front matter |
| `templates/` | The page shapes. `head.html` and `crumbs.html` are partials the rest pull in |
| `lua/` | The filters. Anything a template cannot express lives here |
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `about.md`, `colophon.md` and `404.md` |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/font/` | ET Book, three cuts, served from this domain |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons, images, `CNAME`, and `resume.pdf` |

Changing the shape of a page means editing an HTML file in `templates/`.
Changing what a page knows about itself means editing `lua/page.lua`.

`templates/home.html` is the front page, written out whole, with a
`$for(recent)$` loop where the recent posts go.

## Writing a post

```bash
make new t="Some Post"
```

Every post starts as a draft. Front matter is YAML.

```markdown
---
title: "Some Post"
date: 2026-07-12
draft: true
---
```

| Field | Notes |
|---|---|
| `title` | Required |
| `date` | Rendered under the title. Required for a post under `blog/`. May carry a time, so a day can hold two posts |
| `description` | Used for the meta description and for the summary line in a section listing. Falls back to the opening paragraph for the meta tag only |
| `slug` | Overrides the URL, which otherwise comes from the filename |
| `draft` | `true` keeps it out of `make build`. `make` shows it anyway |

## Asides

An aside is a margin note, written as a standard Markdown footnote: a marker
where the claim is, and a definition anywhere in the file.

```markdown
The measure is `68ch`.[^measure]

[^measure]: Which is wide. It suits a document.
```

The generator emits no numbers. The visible number comes from a CSS counter, so
the marker and its note cannot drift apart. Below about `63em` of window there
is no gutter to float into, and the note folds inline behind a toggle.

Note ids are `sn-1`, `sn-2`, numbered by first appearance. Pandoc's reader
discards the label before a filter can see it, and the id only binds a label to
its checkbox inside one page, so the number is enough. A second reference to one
note emits only the marker and points at the note the first one wrote.

A definition that nothing references fails the build, which is how a mistyped
label gets caught. An unresolved `[^` in prose is left alone, because `[^` is
ordinary text more often than it is a note.

## The feed

`/index.xml` and `/blog/index.xml` are the same document, differing only in the
address each advertises as its own. Both carry blog posts and nothing else, and
both are linked from the head. Each is linked from an `.rss-badge` beside the
heading of the list it feeds. Only a section that publishes a feed draws the
badge, so the projects page has none.

Items carry the full post. A feed has no margin and no stylesheet, so each post
is rendered a second time with its notes as numbered endnotes and every anchor
absolute, because a feed item is read away from the page it came from.

## The look

Set in [ET Book](https://edwardtufte.github.io/et-book/), left aligned inside a
sheet that is centered in the window, held to a `68ch` measure with a gutter
beside it for margin notes. Colors come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors), `modus-operandi` for
light and `modus-vivendi` for dark, and they carry through to syntax
highlighting.

Syntax highlighting is pandoc's, remapped to the Chroma class names the
stylesheet already carried. `lua/code.lua` holds that mapping. Code follows the
theme rather than shipping one of its own.

Every page opens on the same breadcrumb line with the theme toggle beside it. A
post reads `vetr0s.dev / blog`. Home is just the wordmark. There is no menu.

More of that, including what changed and why, is written up at
[vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
