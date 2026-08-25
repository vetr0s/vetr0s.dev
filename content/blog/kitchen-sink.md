---
title: "Kitchen Sink"
description: "Every content feature the site knows how to render, on one page."
date: 2026-07-12
draft: true
tags:
  - test
  - design
---

This post exists to be looked at, not read. It uses every feature the layouts
and stylesheet support, so that changing the CSS has somewhere to fail loudly.
It is a draft, so it never reaches the built site. `./dev` shows it, and
`./dev --build` does not.

## Prose, and what it can carry

Body text fills the sheet. An aside is an inline disclosure,[^an-aside] so it
waits behind its marker until the reader opens it.

[^an-aside]: The marker stays beside the claim. This text opens below the
    sentence at every window width.

Numbering runs down the page in order and comes from a CSS
counter[^numbering-is-css], not from the generator.

[^numbering-is-css]: Notes carry [links](/colophon/), `code`, and *emphasis*
    like any other prose. Because the number is a counter, the markup holds no
    numbers at all and the marker and its note cannot drift apart.

The interaction does not change when the window narrows.

Inline, prose can carry **bold**, *italic*, `inline_code()`, a
[link to another site](https://andrewkelley.me/), a [link back
home](/colophon/), and ~~text struck through~~. Links are underlined, because
that is what a link looks like when nobody has styled it.

### A third-level heading

Headings run `h1` warm-yellow, `h2` magenta, `h3` cyan, on a 1.15 scale anchored
to the body size. Only the `h1` carries a rule under it.

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

1. Install Odin and `libcmark`
2. Run `./dev`
3. There is no step three

## Code

Inline code like `ostat build .` sits in a bordered box. A fenced block does
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

A block wide enough to overflow the page scrolls inside its own box rather
than pushing the page sideways:

```text
this line is deliberately far too long to fit inside the page and should produce a horizontal scrollbar on the block itself, never on the page
```

## Quotes

> A quote sits on a rule and goes muted. It is not a callout and does not want
> to be one.

## Tables

| Path | What lives there |
|---|---|
| `site.json` | The site's identity: title, brand, contact, home page links |
| `content/` | The markdown, and nothing else |
| `static/css/style.css` | The whole stylesheet |

## Images

A picture sits in the flow, capped well short of the page, with its caption
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
