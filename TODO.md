# TODO

## Make the stylesheet its own project

`static/css/style.css` is the main visual asset here. Two generators have come
and gone underneath it. That is the argument for treating it as a thing in its
own right rather than as a file this repo happens to hold.

That means auditing it first. It carries the full Chroma class vocabulary
inherited from Hugo, most of which nothing emits any more, and it has some dead
highlighting rules inherited from Hugo. Find the dead rules, name the
constants that are load bearing, and work out which parts are decisions and
which are leftovers.

Then rewrite it to be exactly what I want rather than what accreted. Rock solid
means the sheet, inline disclosures, and content components have direct rules
without historical branches.

## Update the favicon

The icon set dates from the first commit and has not been looked at since. Six
files: `favicon.ico`, 16 and 32 pixel PNGs, an apple touch icon, and two Android
Chrome sizes.

`site.webmanifest` is worse than stale. `name` and `short_name` are both empty
strings, so an installed shortcut has no label. `theme_color` and
`background_color` are both hardcoded `#ffffff` on a site that follows the
system light and dark preference, so the splash is white regardless.

Fix the manifest whether or not the artwork changes. That part is wrong now, not
merely old.

## Add work experience

Add a work experience section to the about page. Write a companion article
about my work experience so far and what I learned from it.
