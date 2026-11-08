# Review: visited-link-color

## Bugs
None

## Spec gaps
- Criterion 3 was closed by the owner's manual check instead of a screenshot. In `swag serve`, the owner clicked a link, went back, and saw it render blue. The automated screenshot was not usable because its control run with the old CSS also rendered blue.

## Missing tests
None

## Checks done
- Criterion 1: no `visited` in `static/style.css`, `docs/style.css`, `layouts/`, or any file under `docs/`. `a { color: #89a6ff; }` is unchanged at line 14 of both CSS files.
- Criterion 2: `cmp static/style.css docs/style.css` exits 0.
- Criterion 4: `git status --short docs/` shows only `docs/style.css`.
- Cascade claim: the only `a` selector in `static/style.css` is line 14. Layouts have no `<style>` blocks or `style=` attributes. Every built page links only `/style.css`. Nothing else sets link color, so visited links inherit the blue rule.
