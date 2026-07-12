# vetr0s.dev

My personal site: some writing, a few projects, and a page about who I am. A
Hugo static site with hand written templates and CSS, no theme and no
framework. It loads no web fonts, so text renders on the first paint, and it
ships one small script for the light/dark toggle.

[![Deploy](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml/badge.svg)](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml)

## Running it

You need [Hugo](https://gohugo.io/). That's the whole list.

```bash
hugo server     # localhost:1313, live reload
hugo server -D  # include drafts
```

`hugo --minify` writes the built site to `public/`. That directory is not
committed: GitHub Actions rebuilds it from source on every push to `main` and
publishes it to GitHub Pages.

## How it's laid out

| Path | What lives there |
|---|---|
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `colophon.md` |
| `layouts/index.html` | The home page, written out by hand rather than generated from content. The portrait is the `.margin-note.portrait` aside in the About section — swap its `src` to change the picture |
| `layouts/_default/` | `baseof.html`, `single.html` for a post, `list.html` for a section |
| `layouts/partials/` | `head.html`, `header.html`, `footer.html` |
| `layouts/shortcodes/` | `aside.html`, the margin note |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons, images, `resume.pdf` |

## Writing a post

```bash
hugo new content/blog/some-post.md
```

The archetype starts every post as a draft. Front matter:

| Field | Notes |
|---|---|
| `title` | Defaults to the filename, title cased |
| `date` | Rendered under the title. A post without one renders no dateline |
| `draft` | `true` keeps it out of a normal build. Flip it to publish |

A margin note goes in the gutter beside the text:

```markdown
{{< aside >}}A note, or an image and a caption.{{< /aside >}}
```

On a wide screen it floats to the right of the column and the prose wraps
around it. On a narrow one there is no room for a gutter, so it drops back into
the flow as a bordered block.

## The look

Plain HTML, left aligned. The page starts at the left margin and stops at its
measure — prose is held to `80ch` inside a `100ch` column, and the gap between
the two is the gutter the margin notes float into. Nothing is centered.

Colors come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors), `modus-operandi`
for light and `modus-vivendi` for dark, and they carry through to syntax
highlighting, so code follows the theme rather than shipping one of its own.
The typography follows [protesilaos.com](https://protesilaos.com/): system
fonts on a modular scale. The margin note is from [Tufte
CSS](https://edwardtufte.github.io/tufte-css/).

The home page carries the nav banner. Posts and project pages do not — they get
a breadcrumb line instead (`vetr0s.dev / blog`) with the theme toggle beside it,
so the page opens on its own title and still has a way back out.

More of that is written up at [vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
