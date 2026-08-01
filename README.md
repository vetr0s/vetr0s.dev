# vetr0s.dev

My personal site. Some writing, a few projects, and a page about who I am. It is
built by [ostat](https://github.com/vetr0s/ostat), a static site generator I
wrote in [Odin](https://odin-lang.org/). No theme, no framework, no template
language. It ships one small script for the light/dark toggle.

[![Deploy](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml/badge.svg)](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml)

## Running it

```bash
./dev            # build with drafts, serve on localhost:1313
./dev --build    # the production build CI does, into public/
./dev --clean    # discard public/ first, then serve
```

`./dev` uses `ostat` from your `PATH` if it is there. Otherwise it builds a
sibling checkout at `../ostat`, which is where the generator lives when the two
are worked on together. That needs [Odin](https://odin-lang.org/docs/install/)
and `libcmark` (`brew install cmark`).

There is no file watcher and no live reload. A whole build takes milliseconds,
so rebuilding is ctrl-c and rerun.

`public/` is not committed. GitHub Actions rebuilds it from source on every push
to `main` and publishes it to GitHub Pages.

## How it's laid out

| Path | What lives there |
|---|---|
| `site.json` | The site's identity: title, base URL, description, author, locale, the brand split |
| `html/home.html` | The front page, written out whole. `<!--ostat:recent-->` marks where ostat drops the recent posts |
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `about.md` and `colophon.md` |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/font/` | ET Book, three cuts, served from this domain |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons, images, `CNAME`, and `resume.pdf` |

The front page and the two halves of every page's `<head>` live in `html/` and
are ordinary HTML. Everything else is a procedure in ostat's `src/render.odin`,
so changing the shape of a post or a section listing means editing the generator
and rebuilding it. That is the trade ostat makes: no template language to learn
and a compiler that checks the whole thing, at the cost of recompiling to move a
heading.

`html/` may also hold `header-01.html`, `header-02.html` and
`not-found-404.html`. This site supplies none of them and takes ostat's
defaults, which is why its favicons and stylesheet links are the generator's.

## Writing a post

```bash
ostat new blog/some-post -s .
```

Every post starts as a draft. Front matter is a `---` fence around literal JSON.
No YAML, no TOML.

```markdown
---
{
    "title": "Some Post",
    "date": "2026-07-12",
    "draft": true
}
---
```

| Field | Notes |
|---|---|
| `title` | Required |
| `date` | Rendered under the title. Required for a post under `blog/` |
| `description` | Used for the meta description. Falls back to the opening paragraph |
| `slug` | Overrides the URL, which otherwise comes from the filename |
| `draft` | `true` keeps it out of a normal build. `./dev` shows it anyway |

An aside is a margin note, written as a standard Markdown footnote: a marker
where the claim is, and a definition anywhere in the file.

```markdown
The measure is `80ch`.[^measure]

[^measure]: Which is wide. It suits a document.
```

The generator emits no numbers. The visible number comes from a CSS counter, so
the marker and its note cannot drift apart. Below about `70em` of window there
is no gutter to float into, and the note folds inline behind a toggle.

A definition that nothing references fails the build, which is how a mistyped
label gets caught. An unresolved `[^` in prose is left alone, because `[^` is
ordinary text more often than it is a note.

## The feed

`/index.xml` and `/blog/index.xml` are the same document. Both carry blog posts
and nothing else, and both are advertised in the head. Each is linked from an
`.rss-badge` beside the heading of the list it feeds. Only a section that
publishes a feed draws the badge, so the projects page has none.

Items carry the full post. A feed has no margin and no stylesheet, so each post
is rendered a second time with its notes as numbered endnotes and every anchor
absolute, because a feed item is read away from the page it came from.

## The look

Set in [ET Book](https://edwardtufte.github.io/et-book/), left aligned, held to
an `80ch` measure with a gutter beside it for margin notes. Colors come from
Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors), `modus-operandi` for
light and `modus-vivendi` for dark, and they carry through to syntax
highlighting. Code follows the theme rather than shipping one of its own.

Every page opens on the same breadcrumb line with the theme toggle beside it. A
post reads `vetr0s.dev / blog`. Home is just the wordmark. There is no menu.

More of that, including what changed and why, is written up at
[vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
