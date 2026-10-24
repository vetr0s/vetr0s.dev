---
title: Adding swag to my zero-dependency static website generator
date: 2026-10-23
description: Swapping Emacs for a small Go program, and counting what this site actually depends on.
---

A month ago I wrote about building this site with nothing but Emacs and Org mode. I called it a [zero-dependency static website generator](zero-dependency-static-site-generator.html). This site now builds with a tool I wrote instead. It is called swag, short for Static Website Assembler and Generator. The switch made me count what the site really depends on, and the old count was wrong.

## What changed

The posts are now Markdown files, and I write them in neovim. A single Go binary called `swag` turns the `content/` directory into the `docs/` directory that GitHub Pages serves. Every URL from the Org version still works, so old links and the RSS feed did not move.

The repository looks like this now:

```
content/    Markdown pages and posts
layouts/    HTML templates that wrap each page
static/     CSS, images and CNAME, copied as is
docs/       generated site served by GitHub Pages
swag.conf   site title, URL and description
```

The config is a plain `key = value` file:

```
site.title        = Nathan Tebbs
site.url          = https://vetr0s.dev
site.description  = Notes on software and the things I learn while building.
params.stylesheet = /style.css
```

Every post starts with a front matter block:

```markdown
---
title: Adding swag to my zero-dependency static website generator
date: 2026-10-23
description: Swapping Emacs for a small Go program.
---
```

That is not YAML. Each line is a key, a colon and a value. swag has no YAML parser, and it doesn't need one.

## Why I left Org Publish

My editor changed. I moved my day-to-day work from Emacs to neovim, and the build had to move out of the editor with it. The Org setup only ran inside Emacs, either through `M-x` or through a batch Emacs process. Keeping Emacs installed just to publish a blog felt backwards.

I also wanted a few things Org Publish made awkward:

- A preview server that rebuilds and reloads the browser when I save.
- A build that fails on a broken internal link.
- Errors that name a file and a line, so neovim can jump to them.
- Output that stays byte-identical between builds, so `git diff docs/` shows only real changes.

I did not want a framework. swag has no plugins, no themes, no tags and no pagination. It is about 2,000 lines of Go plus 1,100 lines of tests, and I can read the whole thing in an afternoon.

## Counting dependencies honestly

"Zero dependency" was never literal. Here is how I count now.

Level 0 is the platform the generator runs on. Every option needs one. Before, the platform was Emacs. Org mode ships with Emacs, so I counted Org Publish as free. That was only true because Emacs was already my editor. Syntax highlighting also needed `htmlize`, which is a third-party package. Doom Emacs happened to install it for me, so I never noticed.

Now the platform is Go. Go compiles swag, and swag uses only the standard library. Its `go.mod` has no `require` lines:

```
module github.com/vetr0s/swag

go 1.27.3
```

A test fails if that ever changes. The compiled result is one 13 MB binary, and running it needs no Go toolchain.

That leaves one real addition, which is pandoc. swag contains no Markdown parser. For every `.md` file it runs a command from the config, writes the post body to that command's stdin, and reads HTML back from its stdout. The default command is pandoc:

```
render.md = pandoc --from=gfm --to=html5
```

Pandoc also does the syntax highlighting, so `htmlize` is gone. A site written in plain `.html` files would not need pandoc at all.

So the honest before and after:

```
before:  Emacs (platform) + Org (bundled) + htmlize
after:   Go (platform)    + pandoc
```

I swapped one platform for another and traded `htmlize` for pandoc. The count did not drop to zero. It stayed at one, and this time I can name it.

## How I use it

Writing a post starts with `swag new`. It prints only the path of the file it creates, so it composes with the editor:

```sh
nvim "$(swag new 'Adding swag to my zero-dependency static website generator')"
```

The new file starts as a draft. While I write, `swag serve` runs in another terminal. It builds into a temporary directory, never into `docs/`, and serves the result on localhost. It checks for changes every 500 milliseconds and reloads the browser after each rebuild.

Inside neovim, `swag build` works as a make program:

```vim
:set makeprg=swag\ build
:make
```

Errors come out as `path:line: message`, so a bad date or a broken link lands in the quickfix list:

```
content/posts/about-me.md:3: invalid date "2026-13-01": use YYYY-MM-DD
content/posts/colophon.md: broken link "/posts/old.html"
```

A full build of this site takes about 130 milliseconds. swag builds into a temporary directory and replaces `docs/` only after every step has passed. A broken post can't leave half a site behind.

Publishing did not change. I run `swag build`, commit `docs/` and push, and GitHub Pages serves the files.

## Where it lives

swag is on GitHub at [vetr0s/swag](https://github.com/vetr0s/swag) under the MIT license. The source for this site is at [vetr0s/vetr0s.dev](https://github.com/vetr0s/vetr0s.dev). If you have Go installed, this gets you the same binary:

```sh
go install github.com/vetr0s/swag@latest
```

I built swag for one site and one maintainer. If it fits your site too, take it.
