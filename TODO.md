# TODO

## Center the sheet below the fold breakpoint

Below `63em` the margin notes fold inline and the gutter they floated into
becomes dead space inside the sheet. The prose keeps its measure at the left and
the empty gutter sits to its right, so the page reads left-heavy at exactly the
widths where the sheet fills the window and its centering is invisible. Roughly
730px to 1010px.

This predates the centered sheet and is not a regression. It is more visible
now, because the sheet is the unit the eye reads the page by.

The change itself is one line. Set `--layout-width` to just `--measure` inside
the existing fold query in `static/css/style.css`, which drops the gutter from
the sheet and lets the sheet center at its narrower width.

The cost is a third hand-maintained constant. The query that drops the sheet's
side borders is tied to the fold breakpoint at `63em`, on the argument that
below it the sheet fills the window and the borders would hug the screen. That
argument stops holding: a 729px sheet in a 1000px window has page showing at
either side and wants its borders. So the border query needs its own breakpoint,
derived from `--measure` plus `--pad`, kept in step by hand alongside the two
the stylesheet already documents at length.

Decide whether the left-heavy band is worth that. Doing nothing is a real
option.

## Make the stylesheet its own project

`static/css/style.css` is 646 lines and it is the actual asset here. Two
generators have come and gone underneath it and it survived both untouched,
which is the argument for pulling it out and treating it as a thing in its own
right rather than as a file this repo happens to hold.

That means auditing it first. It carries the full Chroma class vocabulary
inherited from Hugo, most of which nothing emits any more, and it has at least
three hand-maintained breakpoint constants that have to be kept in step by hand.
Find the dead rules, name the constants that are actually load bearing, and work
out which parts are decisions and which are leftovers.

Then rewrite it to be exactly what I want rather than what accreted. Rock solid
means the fold behaviour, the sheet centering, and the margin notes are all
derived from constants that are stated once.

## Add the rest of the projects

`content/projects/` holds one page, and it is for the tool I just retired. The
projects section reads as a graveyard.

## Write a post

`content/blog/` has one file and it is the kitchen sink fixture. The blog has
never published anything. The whole point of the last two rebuilds was to make
writing easier, and that claim is untested until something ships.
