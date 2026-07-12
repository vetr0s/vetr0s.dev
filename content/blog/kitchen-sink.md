+++
date = '2026-07-12'
draft = true
title = 'Kitchen Sink'
description = 'Every content feature the site knows how to render, on one page.'
+++

This post exists to be looked at, not read. It uses every feature the templates
and stylesheet support, so that changing the CSS has somewhere to fail loudly.
It is a draft, so it never reaches the built site — `./dev` shows it, and
`./dev --build` does not.

## Prose, and what it can carry

Body text is held to an `80ch` measure inside a `100ch` column. That gap on the
right is the gutter, and it is where margin notes go. {{< aside >}}A margin note.
It floats to the right edge of the column, so it sits mostly *beside* the prose
rather than carving a third out of it. Only the tail of each line tucks around
it.{{< /aside >}} A paragraph beside a note gives up the last few characters of
each line and no more, which is the whole reason the column is wider than the
measure. On a screen narrower than `60em` there is no room for a gutter at all,
so the note drops back into the flow as a bordered block — shrink the window
until it does.

Inline, prose can carry **bold**, *italic*, `inline_code()`, a
[link to another site](https://andrewkelley.me/), a [link back
home](/colophon/), and ~~text struck through~~. Links are underlined, because
that is what a link looks like when nobody has styled it.

### A third-level heading

Headings run `h1` warm-yellow, `h2` magenta, `h3` cyan, on a 1.2 scale. Only the
`h1` carries a rule under it.

#### And a fourth

Which is plain, and the smallest heading the scale defines.

## Lists

Unordered, with nesting:

- A first item
- A second item, which is long enough to wrap onto a second line so that the
  hanging indent has a chance to be wrong
  - A nested item
  - Another nested item
- A third item

Ordered:

1. Install Hugo
2. Run `./dev`
3. There is no step three

## Code

Inline code like `hugo server -D` sits in a bordered box. A fenced block does
not repeat that border on every token — the surface belongs to the block:

```zig
const std = @import("std");

pub fn main() !void {
    // Comments are muted and italic.
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"world"});
}
```

```bash
./dev            # serve locally, drafts included
./dev --build    # production build into public/
```

A block wide enough to overflow the measure scrolls inside its own box rather
than pushing the page sideways:

```text
this line is deliberately far too long to fit inside the measure and should produce a horizontal scrollbar on the block itself, never on the page
```

## Quotes

> A quote sits on a rule and goes muted. It is not a callout and does not want
> to be one.

## Tables

| Path | What lives there |
|---|---|
| `layouts/index.html` | The home page, and the portrait slot |
| `layouts/partials/header.html` | The banner on home, the breadcrumb everywhere else |
| `static/css/style.css` | The whole stylesheet |

## Images

An image in a margin note gets a caption under it:

{{< aside >}}
<img src="/img/huston_pit.webp" alt="Our team's pit at the FRC World Championships in Houston" />
<small>A margin note whose payload is a picture.</small>
{{< /aside >}}

An image in the flow runs to the measure, and no further. The one below is the
same picture, unconstrained by a gutter.

![Our team's pit at the FRC World Championships in Houston](/img/huston_pit.webp)

---

That rule above is an `<hr>`. Below this line there is nothing but the footer,
and above it, on this page, there is a breadcrumb instead of a banner: this is
a post, so it opens on its own title and keeps a way back out.
