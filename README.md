# vetr0s.dev

My personal site. It holds my writing, projects, and a page about me. Pandoc
builds the site through `make`. HTML templates define the pages and Lua filters
handle the transformations that templates cannot express.

## Run it

The site requires Pandoc 3. `make serve` also requires Python 3.

```sh
make          # build drafts into public/
make serve    # build and serve on localhost:1313
make build    # build the published site into docs/
make clean    # remove both output trees
make new      # create a draft post
```

Set `PORT` to change the local server port. Set `V=1` to print the Pandoc
commands during a build.

## Publish it

GitHub Pages serves `main:/docs`. The `docs/` directory is committed. The
`public/` preview directory is not.

```sh
make build
git diff -- docs/
```

Publishing means reviewing the generated changes, committing `docs/`, and
pushing the commit.

## Layout

| Path | Contents |
| --- | --- |
| `site.yaml` | Site title, base URL, description, author, and locale |
| `templates/` | Page templates and shared HTML fragments |
| `lua/` | Pandoc filters |
| `content/` | Posts, projects, and standalone pages |
| `static/css/` | The reset and site stylesheet |
| `static/font/` | ET Book font files |
| `static/js/` | The light and dark theme toggle |
| `static/` | Images, favicons, `CNAME`, and my resume |

The home page introduction lives in `content/_index.md`. Project front matter
selects the featured projects shown there.

## Create a post

```sh
make new
```

The command asks for a title and creates a draft with YAML front matter:

```yaml
---
title: "Some post"
date: 2026-07-12
draft: true
tags:
  - programming
---
```

The filename owns the URL. Set `draft: false` when the post is ready to appear
in `make build`.

The [colophon](https://vetr0s.dev/colophon/) covers the design and the decisions
behind it.
