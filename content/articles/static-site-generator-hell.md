---
title: "Static Site Generator Hell"
description: "I wrote a static site generator in Odin, used it for this site, and replaced it when maintaining the generator displaced the writing."
date: 2026-08-25
draft: true
tags:
  - programming
  - web
  - tools
image: /static-site-generator-hell.png
image_alt: "A complex printing machine beside a small press, an empty frame, and a simple binding tool."
image_width: 1400
image_height: 583
---

<p class="article-context">Context: <a href="/projects/ostat/">ostat</a>, the
generator this article discusses, and <a href="https://gohugo.io/">Hugo</a>,
the generator it replaced.</p>

## Foreword

This site used to be built by a static site generator I wrote in Odin. It
reached about three thousand lines, had more than a hundred tests, and produced
every page, feed, and sitemap here. Then I replaced it with Pandoc and Make.

A static site generator reads source files and writes the finished HTML files a
web server sends to visitors. It does this work before anyone opens the site.
There is no application server assembling a page for each request.

The generator worked. That was not enough reason to keep it.

## Motivation

Hugo built the first version of this site. It was fast and dependable. It was
also a large program with a template language, a theme system, and a plugin
model. My site had fewer than ten pages. I could describe every page it needed
to produce.

I also wanted to learn Odin through a real project. Odin is a systems programming
language aimed at direct control over data and memory. A static site generator
was a good fit. It had file traversal, parsing, allocation, sorting, date
handling, HTML generation, and enough edge cases to punish a weak design. The
program ran as one batch job, so two arenas and no individual frees covered
almost the whole memory strategy.[^arenas]

[^arenas]: One arena held data that lived for the full build. The other was
    cleared between pages. An arena reserves a region of memory and releases it
    all at once. The operating system reclaimed both arenas when the process
    exited.

The goal was not to make a general replacement for Hugo. The goal was to own
the exact path from my Markdown to the bytes served at vetr0s.dev.

## What ostat owned

The content folders determined the public addresses. A file named `_index.md`
became its directory's section page. Every other Markdown file became a regular
page. The same scan supplied section listings and the home page. It also built
the RSS feeds that notify feed readers about new posts. The sitemap listed the
site's public pages for search engines.

The generator also handled notes, syntax highlighting, draft and future
post filtering, summaries, and dates with enough precision to order two posts
on one day. A small example site acted as a fixture. Its expected output caught
changes to the generated files. Unit tests covered the pieces underneath it.

There was no template language. A template language normally lets a page mix
HTML with placeholders and loops. Each layout was instead an Odin function that
wrote HTML. That made page structure explicit. The compiler caught programming
mistakes in the layout code before the generator ran. It also meant moving a
heading required changing and rebuilding the generator.[^layout]

[^layout]: This trade felt good while the generator was the project. It felt
    different once I wanted the site itself to be the project.

## What ostat's ownership model bought

The whole system fit in my head. When a URL was wrong, I knew which function had
made it. When a note needed different markup, I changed the procedure
that wrote it. There was no framework behavior to discover and no extension
point to work around.

That clarity made the generator a useful systems exercise. I learned Odin well
enough to make design choices instead of translating habits from another
language. I learned how much simpler allocation becomes when every object has
the same lifetime. I learned where a static site stops being a set of pages and
starts being a build graph. A build graph records which outputs depend on which
inputs. That relationship decides what must be rebuilt after a file changes.

The project answered the questions I had asked of it.

## The tradeoffs changed

The cost appeared when I tried to work on the site. A new presentation detail
often meant generator work. A page-level idea crossed into compiled layout code.
Small changes asked me to reload the whole implementation in my head before I
could make them confidently.

None of that made the design wrong. The compiler still checked the layouts.
The generator still produced the right files. Its benefits had stopped matching
the work I wanted to do.

I had written more generator than site. Keeping that ratio would have meant
spending more time maintaining the path to the writing than writing anything.

## Replacing ostat

Pandoc now turns Markdown into HTML. HTML templates hold the page shapes. Small
programs written in Lua change the parts that templates cannot express. Make
records which outputs depend on which source files, then rebuilds only what
changed.

The core of the article template is plain HTML with Pandoc placeholders:

```html
<article>
  <h1>$title$</h1>
  $body$
</article>
```

The Makefile connects a Markdown source file to its HTML output. This shortened
rule shows the relationship:

```makefile
$(OUT)/%/index.html: content/%.md $(DEPS)
	pandoc --template=templates/page.html -o $@ $<
```

Make replaces `$<` with the source filename and `$@` with the output filename.
The rule says that a page must be rebuilt when its Markdown file, template, or
filter changes.

This setup is less mine. That is the point. Pandoc owns Markdown parsing and
syntax highlighting. Make owns incremental builds. I own the content, the HTML,
the filters specific to this site, and the stylesheet.

The split puts each change where I expect to find it. Moving a heading means
editing a template. Changing a note means editing one Lua filter.
Changing the page width means editing one CSS token. A full production build
takes a few seconds.

## What survived

The URLs did not change. The content folders still define them. The document
layout, notes, syntax colors, RSS feeds, and restrained navigation all survived.
Those were site decisions rather than generator decisions.

The generator survives too. Its source and releases remain available, and the
project page records how it worked. I stopped using it because the experiment
was complete, not because the work was wasted.

Building a layer yourself can be the right way to learn it. Keeping that layer
forever is a separate decision.
