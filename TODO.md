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
