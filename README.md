# vetr0s.dev

My personal site. Some writing, a few projects, and a page about who I am. It
is a Hugo static site with hand-written templates and CSS. No theme, no
framework. It loads no web fonts. Text renders on the first paint. It ships one
small script for the light/dark toggle.

[![Deploy](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml/badge.svg)](https://github.com/vetr0s/vetr0s.dev/actions/workflows/deploy.yml)

## Running it

You need [Hugo](https://gohugo.io/). That's the whole list.

```bash
hugo server     # localhost:1313, live reload
hugo server -D  # include drafts
```

`hugo --minify` writes the built site to `public/`. That directory is not
committed. GitHub Actions rebuilds it from source on every push to `main` and
publishes it to GitHub Pages.

## How it's laid out

| Path | What lives there |
|---|---|
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `about.md` and `colophon.md` |
| `layouts/index.html` | The home page, written by hand rather than generated from content. It carries contact details, the list of everywhere else, and recent posts. The portrait is the `.portrait` div. Swap its `src` to change the picture |
| `layouts/_default/` | `baseof.html`, `single.html` for a post, `list.html` for a section |
| `layouts/partials/` | `head.html`, `header.html`, `footer.html`, plus `fn.html` and `footnotes.html` |
| `layouts/shortcodes/` | `fn.html`, the footnote |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons and images |

`resume.pdf` is the exception. It is not committed here. It is built in
[vetr0s/resume](https://github.com/vetr0s/resume). The deploy pulls the current
copy into `static/` on every build, so the served resume cannot fall behind the
source. Pushing a new PDF there triggers a deploy here. `./dev` fetches a copy
for local work.

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

An aside is a footnote. Write it against the claim it qualifies. Leave no space
before the shortcode.

```markdown
The measure is `80ch`.{{< fn >}}Which is wide. It suits a document.{{< /fn >}}
```

That writes a numbered marker in place and queues the note. `single.html` and
`list.html` flush the queue at the end of the page. The notes come out under a
rule at the bottom, in the order they were written. Numbering is automatic.

Shortcodes do not run in hand-written HTML. A template calls the partial the
shortcode wraps:

```gotemplate
{{ partial "fn.html" (dict "page" . "body" `The note, as HTML.`) }}
```

Then it flushes the queue wherever the list should land:

```gotemplate
{{ partial "footnotes.html" . }}
```

Numbering keeps running across flushes. One page can hold more than one list.

## The look

Plain HTML, left aligned. The page starts at the left margin and stops at its
measure. The measure is `80ch`, and it is the whole column. There is no gutter.
Asides are footnotes. Nothing needs room beside the prose. Nothing is centered.

Colors come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors). `modus-operandi`
for light, `modus-vivendi` for dark. They carry through to syntax highlighting.
Code follows the theme rather than shipping one of its own.

The typography follows [protesilaos.com](https://protesilaos.com/). System
fonts on a modular scale. Writing the aside where the claim is, rather than
collecting it in a sidebar at the end, comes from [Tufte
CSS](https://edwardtufte.github.io/tufte-css/).

Every page opens on the same breadcrumb line with the theme toggle beside it. A
post reads `vetr0s.dev / blog`. Home is just the wordmark. There is no menu.
The home page is the index, and it carries the list of everywhere else. A post
climbs to its section. A section climbs home. Home has the rest.

More of that is written up at [vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
