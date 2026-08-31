# Build the site with pandoc.
#
#   make            build with drafts and future posts into public/, serve
#   make build      the published build, into docs/
#   make clean      discard both output trees
#   make new        start a post under content/articles/
#
# PORT overrides the port, default 1313. V=1 prints each pandoc command line
# instead of a label.
#
# There is no file watcher and no live reload. A whole build takes about a
# second, so rebuilding is ctrl-c and rerun.

MODE ?= dev
PORT ?= 1313
PANDOC ?= pandoc

ifeq ($(MODE),prod)
  OUT   := docs
  FLAGS :=
else
  OUT   := public
  FLAGS := -M drafts=1 -M future=1
endif

SRCS := $(wildcard content/*.md content/*/*.md)

# A published build skips drafts and posts dated ahead of today. A dev build
# shows both, because it is for looking at the thing rather than for checking
# what the world will see.
ifeq ($(MODE),prod)
  LIVE := $(shell today=$$(date -u +%Y-%m-%d); for f in $(SRCS); do \
            grep -qE '^draft: *true' $$f && continue; \
            d=$$(sed -n 's/^date: *//p' $$f | head -1); d=$${d%%T*}; \
            if [ -n "$$d" ] && [ "$$d" \> "$$today" ]; then continue; fi; \
            echo $$f; done)
else
  LIVE := $(SRCS)
endif

POSTS    := $(filter-out content/404.md content/_index.md %/_index.md,$(LIVE))
SECTIONS := $(filter %/_index.md,$(LIVE))

OUT_POSTS    := $(patsubst content/%.md,$(OUT)/%/index.html,$(POSTS))
OUT_SECTIONS := $(patsubst content/%/_index.md,$(OUT)/%/index.html,$(SECTIONS))
OUT_XML      := $(OUT)/index.xml $(OUT)/articles/index.xml $(OUT)/sitemap.xml

TEMPLATES := $(wildcard templates/*.html templates/*.xml)
FILTERS   := $(wildcard lua/*.lua)
DEPS      := site.yaml $(TEMPLATES) $(FILTERS)

# Reader extensions that are each the difference between the intended markup
# and a diff: heading ids used by self-links, a raw HTML block pandoc would
# relayout, and a lone image becoming a captioned <figure>.
FROM  := markdown-markdown_in_html_blocks-implicit_figures
PD    := $(PANDOC) --standalone --metadata-file=site.yaml --wrap=preserve -f $(FROM) -t html5
NOTES := --lua-filter=lua/sidenotes.lua --lua-filter=lua/highlight.lua

# V=1 prints the pandoc command line for each target instead of the label.
V ?= 0

# $(1) is the label, $(2) the command. A note defined and never referenced is a
# mistyped label: pandoc reports it and keeps going, so the build promotes it.
define run
@mkdir -p $(@D)
@if [ "$(V)" = 1 ]; then echo "  $(2)"; else printf '  %-6s %s\n' "$(1)" "$@"; fi
@err_file=$$(mktemp); \
  $(2) 2>"$$err_file" >/dev/null; status=$$?; \
  if [ -s "$$err_file" ]; then cat "$$err_file" >&2; fi; \
  if [ $$status -ne 0 ]; then rm -f "$$err_file"; exit $$status; fi; \
  if grep -q "but not used" "$$err_file"; then rm -f "$$err_file"; exit 1; fi; \
  rm -f "$$err_file"
endef

.PHONY: all banner build check check-tools serve clean clean-out copy-static new
.SUFFIXES:

all: check-tools banner $(OUT)/index.html $(OUT_POSTS) $(OUT_SECTIONS) $(OUT_XML) \
     $(OUT)/404.html copy-static
	@echo
	@printf '%s pages, %s feeds, 1 sitemap into %s/\n' \
	  "$$(find $(OUT) -name '*.html' | wc -l | tr -d ' ')" \
	  "$$(find $(OUT) -name '*.xml' ! -name sitemap.xml | wc -l | tr -d ' ')" "$(OUT)"

banner:
	@echo "pandoc $$($(PANDOC) --version | head -1 | cut -d' ' -f2), $(MODE) build into $(OUT)/"
	@printf '%s content files' "$$(echo $(SRCS) | wc -w | tr -d ' ')"
	@if [ "$(MODE)" = prod ]; then \
	  printf ', %s skipped as draft or future\n' \
	    "$$(( $$(echo $(SRCS) | wc -w) - $$(echo $(LIVE) | wc -w) ))"; \
	else printf ', drafts and future posts included\n'; fi
	@echo

check-tools:
	@command -v $(PANDOC) >/dev/null || { echo "pandoc is required" >&2; exit 127; }

build: check-tools
	@rm -rf .build/docs
	@$(MAKE) --no-print-directory MODE=prod OUT=.build/docs all
	@touch .build/docs/.nojekyll
	@python3 scripts/check_site.py .build/docs
	@rm -rf docs
	@mv .build/docs docs
	@echo
	@echo "Built to docs/. Commit it: GitHub Pages serves this tree."

check: check-tools
	@set -e; tmp=$$(mktemp -d); trap 'rm -rf "$$tmp"' EXIT; \
	  $(MAKE) --no-print-directory MODE=prod OUT="$$tmp/site" all; \
	  python3 scripts/check_site.py "$$tmp/site"; \
	  if $(MAKE) --no-print-directory OUT="$$tmp/fail" PANDOC=false all >/dev/null 2>&1; then \
	    echo "a failing pandoc command returned success" >&2; exit 1; \
	  fi

serve: all
	@echo
	@echo "serving $(OUT)/ on http://localhost:$(PORT)"
	@python3 -m http.server $(PORT) --directory $(OUT)

clean:
	@echo "removing public/ and docs/"
	@rm -rf public docs

clean-out:
	@rm -rf $(OUT)

copy-static:
	@mkdir -p $(OUT)
	@printf '  %-6s %s files from static/\n' copy \
	  "$$(find static -type f | wc -l | tr -d ' ')"
	@cp -R static/. $(OUT)/

$(OUT)/%/index.html: content/%.md $(DEPS)
	$(call run,page,$(PD) --template=templates/page.html $(NOTES) \
	  --lua-filter=lua/page.lua -M url=/$*/ -M kind=page -o $@ $<)

$(OUT)/%/index.html: content/%/_index.md $(SRCS) $(DEPS)
	$(call run,list,$(PD) --template=templates/section.html $(NOTES) \
	  --lua-filter=lua/listing.lua --lua-filter=lua/page.lua $(FLAGS) \
	  -M url=/$*/ -M kind=section -o $@ $<)

$(OUT)/index.html: content/_index.md $(SRCS) $(DEPS)
	$(call run,home,$(PD) --template=templates/home.html \
	  $(NOTES) --lua-filter=lua/listing.lua --lua-filter=lua/page.lua $(FLAGS) \
	  -M url=/ -M kind=home -o $@ content/_index.md)

$(OUT)/404.html: content/404.md $(DEPS)
	$(call run,404,$(PD) --template=templates/page.html $(NOTES) \
	  --lua-filter=lua/page.lua -M url=/404.html -M kind=page -o $@ $<)

$(OUT)/index.xml: $(SRCS) $(DEPS)
	$(call run,feed,$(PD) --template=templates/rss.xml \
	  --lua-filter=lua/feed.lua $(FLAGS) -M selfpath=/index.xml -o $@ /dev/null)

# The same document, advertised at both addresses, so the self link differs.
$(OUT)/articles/index.xml: $(SRCS) $(DEPS)
	$(call run,feed,$(PD) --template=templates/rss.xml \
	  --lua-filter=lua/feed.lua $(FLAGS) -M selfpath=/articles/index.xml -o $@ /dev/null)

$(OUT)/sitemap.xml: $(SRCS) $(DEPS)
	$(call run,map,$(PD) --template=templates/sitemap.xml \
	  --lua-filter=lua/sitemap.lua $(FLAGS) -o $@ /dev/null)

new:
	@python3 scripts/new_post.py
