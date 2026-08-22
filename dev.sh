#!/usr/bin/env bash
# Build the site with ostat and serve it.
#
#   ./dev            build with drafts and future posts, serve on $PORT
#   ./dev --build    production build into docs/, the published tree
#   ./dev --clean    discard the output tree first, then serve
#
# PORT overrides the port, default 1313.
#
# There is no file watcher and no live reload. ostat builds the whole site in
# milliseconds, so rebuilding is ctrl-c and rerun.
set -euo pipefail

cd "$(dirname "$0")"

OUT="public"
PORT="${PORT:-1313}"

# ostat on PATH wins. Otherwise a sibling checkout is built, because this site
# and its generator are developed together and that is where it lives.
find_ostat() {
    if command -v ostat > /dev/null; then
        command -v ostat
        return
    fi

    local repo="../ostat"
    if [ ! -d "$repo" ]; then
        echo "ostat is not on PATH and there is no checkout at $repo." >&2
        echo "Clone https://github.com/vetr0s/ostat beside this repo." >&2
        exit 1
    fi

    # ostat's own build.sh handles the cmark linker flag.
    ( cd "$repo" && ./build.sh release > /dev/null )
    echo "$(cd "$repo" && pwd)/build/release/ostat"
}

OSTAT="$(find_ostat)"

case "${1:-}" in
    --build)
        rm -rf docs
        "$OSTAT" build . -o docs
        # Pages runs Jekyll over the tree without this, and ostat does not
        # emit it. Writing it here keeps it from vanishing on every build.
        touch docs/.nojekyll
        echo
        echo "Built to docs/. Commit it: GitHub Pages serves this tree."
        ;;

    --clean | "")
        if [ "${1:-}" = "--clean" ]; then
            rm -rf "$OUT"
        fi

        # Drafts and future posts are on: this is for looking at the thing, not
        # for checking what the world will see.
        "$OSTAT" build . -o "$OUT" -drafts -future

        if ! command -v python3 > /dev/null; then
            echo
            echo "Built to $OUT/, but python3 is missing so there is no server." >&2
            echo "Serve $OUT/ with anything you like, or use ./dev --build." >&2
            exit 1
        fi

        echo
        echo "serving $OUT/ on http://localhost:$PORT"
        exec python3 -m http.server "$PORT" --directory "$OUT"
        ;;

    -h | --help)
        sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'
        ;;

    *)
        echo "dev: unknown option ${1}" >&2
        echo >&2
        sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//' >&2
        exit 2
        ;;
esac
