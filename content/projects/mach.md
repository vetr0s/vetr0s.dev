---
title: "Mach and mach.h"
description: "A factory game and the single-header C engine that grew out of it. A paused experiment in owning a game stack from the renderer up."
status: "Experiment, paused"
featured: 1
source: "https://github.com/vetr0s/mach"
---

Mach is an isometric factory game written in C. Droppers create ore, conveyors
route it, upgraders raise its value, and furnaces turn it into money for the
next expansion. I built the game to learn what changes when an engine and its
first real user grow together.

The engine became [mach.h](https://github.com/vetr0s/mach.h), a single-header
library with an OpenGL 3.3 batch renderer, sprite atlases, bitmap text, arena
allocation, input, audio, and immediate-mode UI layout. The game keeps a copy of
the header in its source tree and builds with a C compiler and system OpenGL.

This project is paused. It was an experiment, and it taught me a great deal
about renderer design, data layout, build systems, and the cost of owning every
layer.

## What I worked on

- A 2D batch renderer and an isometric view built as a coordinate transform
- A simulation made from typed structs in flat arrays inside one arena
- Hot reloading through a host-owned state block and a reloadable game library
- A unity build driven by a small build program written in C
- Release builds for macOS, Linux, and Windows through GitHub Actions

The engine never names a game type. The game owns its loop and calls the engine
directly. That boundary survived the project growing from a renderer experiment
into a playable factory loop.

- [Game source](https://github.com/vetr0s/mach)
- [Engine source](https://github.com/vetr0s/mach.h)
- [Releases](https://github.com/vetr0s/mach/releases)
