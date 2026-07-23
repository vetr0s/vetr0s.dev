+++
date = '2026-07-12'
draft = true
title = 'Kitchen Sink'
description = 'Every content feature the site knows how to render, on one page.'
+++

This post exists to be looked at, not read. It uses every feature the templates
and stylesheet support, so that changing the CSS has somewhere to fail loudly.
It is a draft, so it never reaches the built site. `./dev` shows it, and
`./dev --build` does not.

## Prose, and what it can carry

Body text is held to an `80ch` measure, and that is the whole column: there is no
gutter beside it. An aside is a footnote{{< fn >}}A footnote. The marker is set
where the claim is, the note itself waits under a rule at the end of the post,
and the arrow at the end of this line goes back to where you were.{{< /fn >}}
instead, so a paragraph reads at full width from the first line to the last and
nothing sits in the corner of your eye asking to be read next.

Numbering runs down the page in order, and a marker is a link both
ways{{< fn >}}Notes carry [links](/colophon/), `code`, and *emphasis* like any
other prose.{{< /fn >}} Follow one and the note you land on comes up to full
text color.

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
not repeat that border on every token. The surface belongs to the block:

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
| `layouts/partials/header.html` | The breadcrumb bar, on every page |
| `static/css/style.css` | The whole stylesheet |

## Images

A picture sits in the flow, capped well short of the measure, with its caption
under it:

<figure>
<img src="/img/huston_pit.webp" alt="Our team's pit at the FRC World Championships in Houston" />
<figcaption>A figure, which is how every picture on the site is set.</figcaption>
</figure>

A bare markdown image gets the same cap and no caption.

![Our team's pit at the FRC World Championships in Houston](/img/huston_pit.webp)

---

That rule above is an `<hr>`. Below this line there is nothing but the footer,
and above it the same breadcrumb every page carries: this is a post, so it
climbs to `blog`, and `blog` climbs home.
