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

This is the **first** published article under `/articles/`. Yippee!

## Why I built this site

I wanted one place that points at everything I have made, without a platform
sitting between the reader and the work. I chose to host it on GitHub mainly
because I already do most of my public work on there and they have a convenient little thing called GitHub Pages that lets me host the static website publicly under my domain vetr0s.dev. This site's primary function is to hold the reasoning behind: why a project exists, what it cost, and what I would do differently next time. However, I plan on documenting literally anything that I am nerdy about, not just Computer Science topics... like Music or hiking for example.

The site's build system itself has already gone through a couple different rewrites. It started on Hugo,
moved to [ostat](/projects/ostat/), a static site generator I wrote in Odin,
and now runs on Pandoc and Make. Each move traded one set of tradeoffs for
another. The [colophon](/colophon/) covers what it runs on today. And, knock on wood, this will be the final iteration of the build system since I actually want to start writing instead of toying around with static site generation, which can be fatiguing after awhile.

## What I'm working on

[Projects](/projects/) lists the finished and paused work: [`difr`](/projects/difr/), a
golden-file test runner; [GateRelay](/projects/gaterelay/), a hardened TCP relay; Mach, a factory game
with its own single-header engine; and a crime-data analysis from a data science course I took at University of Arizona that I am particularly proud of.

Mach is the one still open, although I am still deciding whether or not to jump ship since the wonders of SDL3 are quite enticing. The engine, [mach.h](https://github.com/vetr0s/mach.h),
handles rendering, input, audio, and UI. The game is what tests whether those
decisions hold up outside a demo. But if you wanna know more check out the
[projects page](/projects/mach/) for it or [the github itself](https://github.com/vetr0s/mach).

## Wow! Look at these code blocks!

I spent (too much) time on getting a minimal code block highlighting system to work on the website since I hate the idea of a dependency for just highlighting code on my website. So, dear reader, here you may gaze upon these glorious code blocks, and as a bonus the example fits this article quite well!

```c
#include <stdio.h>

int main(int argc, char *argv[])
{
    printf("Hello, World!\n");

    return 0;
}
```

ooo... ahhh...

And here's the "modern" C++ version, for anyone who thinks classic C looks a little too
easy to read:

```cpp
import std;

int main() {
    std::print("Hello, World!\n");
}
```

Thirty-some years of committee meetings to get back to one line and a function call.
Progress!

## What's next

More articles under `/articles/`, written as projects finish rather than
batched up after the fact. I would rather publish something short and
specific than sit on a long post until it feels finished.

I am playing around with a couple ideas for articles. Currently leaning towards a deeper dive into the static site generation stuff since I definitely learned a whole lot!

## A closing note

Thanks for reading the first thing published here. There will be more... I promise!
