---
title: "Hello, World"
description: "The first published article on the rebuilt site, and the two lines that started every language I've used."
date: 2026-08-26
draft: false
tags:
  - meta
image: /hello-world.png
image_alt: "The words Hello, World in light text on a dark blue-to-brown gradient."
image_width: 1400
image_height: 583
---

This is the **first** published article under `/articles/`. Hooray!

## Why I built this site

I wanted one place that points at everything I have made, without a platform
sitting between the reader and the work. This site's primary function is to
explain why a project exists, what it cost, and what I would do differently next
time. However, I plan on documenting anything I find myself getting nerdy about,
like music or hiking.

The site's build system has already gone through a couple of rewrites. It
started on Hugo, moved to [ostat](/projects/ostat/), a static site generator I
wrote in Odin, and now runs on Pandoc and Make. The [colophon](/colophon/)
explains how the site is built today. I hope this is the final build-system
rewrite because I want to write instead of tinkering with static-site
generation.

## What I'm working on

[Projects](/projects/) lists the finished and paused work:
[`difr`](/projects/difr/), a golden-file test runner;
[GateRelay](/projects/gaterelay/), a hardened TCP relay;
[Mach](/projects/mach/), a factory game with its own single-header engine; and a
crime-data analysis from a data science course I took at the University of
Arizona that I am particularly proud of.

Mach is still active, though I may switch it to SDL3. Its engine,
[mach.h](https://github.com/vetr0s/mach.h), handles rendering, input, audio, and
UI. The game tests those decisions outside a demo. For more, see the [Mach
project page](/projects/mach/) or [GitHub
repository](https://github.com/vetr0s/mach).

## Wow! Look at these code blocks!

I spent too much time getting a minimal code-block
highlighting system to work. So... here you may gaze upon these glorious code
blocks. As a bonus, the example fits this article quite well!

```c
#include <stdio.h>

int main(int argc, char *argv[])
{
    printf("Hello, World!\n");

    return 0;
}
```

Ooh. Ahh.

And here's the "modern" C++ version:

```cpp
import std;

int main() {
    std::print("Hello, World!\n");
}
```

Thirty-some years of committee meetings to get back to one line and a function
call. Progress!

## What's next

More articles are on the way! I am playing around with a couple of ideas. I'm
leaning toward a deeper dive into static-site generation or the work I did this
summer on Mach. I learned a lot from both projects. We shall see!

## A closing note

Thanks for reading the first thing published here.
