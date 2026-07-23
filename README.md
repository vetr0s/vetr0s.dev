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
| `content/` | The markdown. Posts under `blog/`, projects under `projects/`, plus `about.md` and `colophon.md` |
| `layouts/index.html` | The home page, written out by hand rather than generated from content: contact details, the list of everywhere else, and recent posts. The portrait is the `.portrait` div in the Contact section — swap its `src` to change the picture |
| `layouts/_default/` | `baseof.html`, `single.html` for a post, `list.html` for a section |
| `layouts/partials/` | `head.html`, `header.html`, `footer.html`, plus `fn.html` and `footnotes.html` |
| `layouts/shortcodes/` | `fn.html`, the footnote |
| `static/css/` | `reset.css` and `style.css`. The entire stylesheet, no build step |
| `static/js/` | `theme.js`, the light/dark toggle |
| `static/` | Everything else served as is: favicons and images |

`resume.pdf` is the exception. It is not committed here: it is built in
[vetr0s/resume](https://github.com/vetr0s/resume), and the deploy pulls the
current copy into `static/` on every build, so the served resume cannot fall
behind the source. Pushing a new PDF there triggers a deploy here. `./dev`
fetches a copy for local work.

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

An aside is a footnote. Write it against the claim it qualifies, with no space
before the shortcode:

```markdown
The measure is `80ch`.{{< fn >}}Which is wide. It suits a document.{{< /fn >}}
```

That writes a numbered marker in place and queues the note. `single.html` and
`list.html` flush the queue at the end of the page, so the notes come out under
a rule at the bottom in the order they were written. Numbering is automatic.

The home page is hand-written HTML, where shortcodes do not run, so it calls the
partial the shortcode wraps:

```gotemplate
{{ partial "fn.html" (dict "page" . "body" `The note, as HTML.`) }}
```

It flushes per folded section rather than once at the end, so a section's notes
stay with the section:

```gotemplate
{{ partial "footnotes.html" . }}
```

## The look

Plain HTML, left aligned. The page starts at the left margin and stops at its
measure, which is `80ch` and is the whole column. There is no gutter: asides are
footnotes, so nothing needs room beside the prose. Nothing is centered.

Colors come from Protesilaos Stavrou's [Modus
themes](https://protesilaos.com/emacs/modus-themes-colors), `modus-operandi`
for light and `modus-vivendi` for dark, and they carry through to syntax
highlighting, so code follows the theme rather than shipping one of its own.
The typography follows [protesilaos.com](https://protesilaos.com/): system
fonts on a modular scale. Writing the aside where the claim is, rather than
collecting it in a sidebar at the end, is from [Tufte
CSS](https://edwardtufte.github.io/tufte-css/).

Every page opens on the same breadcrumb line (`vetr0s.dev / blog`) with the
theme toggle beside it, home included, where it is just the wordmark. There is
no menu: the home page is the index, and it carries the list of everywhere else.
A post climbs to its section, a section climbs home, and home has the rest.

More of that is written up at [vetr0s.dev/colophon](https://vetr0s.dev/colophon/).
