# Build the site with pandoc.
#
#   make            build with drafts and future posts into public/, serve
#   make build      the published build, into docs/
#   make clean      discard both output trees
#   make new t=...  start a post under content/blog/
#
# PORT overrides the port, default 1313.
#
# There is no file watcher and no live reload. A whole build takes about a
# second, so rebuilding is ctrl-c and rerun.

MODE ?= dev
PORT ?= 1313

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

POSTS    := $(filter-out content/404.md %/_index.md,$(LIVE))
SECTIONS := $(filter %/_index.md,$(LIVE))

OUT_POSTS    := $(patsubst content/%.md,$(OUT)/%/index.html,$(POSTS))
OUT_SECTIONS := $(patsubst content/%/_index.md,$(OUT)/%/index.html,$(SECTIONS))
OUT_XML      := $(OUT)/index.xml $(OUT)/blog/index.xml $(OUT)/sitemap.xml

TEMPLATES := $(wildcard templates/*.html templates/*.xml)
FILTERS   := $(wildcard lua/*.lua)
DEPS      := site.yaml $(TEMPLATES) $(FILTERS)

# Reader extensions that are each the difference between the intended markup
# and a diff: heading ids the stylesheet does not use, a raw HTML block pandoc
# would relayout, and a lone image becoming a captioned <figure>.
FROM  := markdown-auto_identifiers-markdown_in_html_blocks-implicit_figures
PD    := pandoc --standalone --metadata-file=site.yaml --wrap=preserve -f $(FROM) -t html5
NOTES := --lua-filter=lua/sidenotes.lua --lua-filter=lua/highlight.lua

# A note defined and never referenced is a mistyped label. Pandoc reports it
# and keeps going, so the build has to promote it.
define pandoc-strict
@mkdir -p $(@D)
@err=$$($(1) 2>&1 >/dev/null); \
  if [ -n "$$err" ]; then echo "$$err" >&2; fi; \
  case "$$err" in *"but not used"*) exit 1;; esac
endef

.PHONY: all build serve clean clean-out copy-static new
.SUFFIXES:

all: $(OUT)/index.html $(OUT_POSTS) $(OUT_SECTIONS) $(OUT_XML) \
     $(OUT)/404.html copy-static

build:
	@$(MAKE) --no-print-directory MODE=prod clean-out all
	@touch docs/.nojekyll
	@echo
	@echo "Built to docs/. Commit it: GitHub Pages serves this tree."

serve: all
	@echo
	@echo "serving $(OUT)/ on http://localhost:$(PORT)"
	@python3 -m http.server $(PORT) --directory $(OUT)

clean:
	rm -rf public docs

clean-out:
	rm -rf $(OUT)

copy-static:
	@mkdir -p $(OUT)
	@cp -R static/. $(OUT)/

$(OUT)/%/index.html: content/%.md $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/page.html $(NOTES) \
	  --lua-filter=lua/page.lua -M url=/$*/ -M kind=page -o $@ $<)

$(OUT)/%/index.html: content/%/_index.md $(SRCS) $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/section.html $(NOTES) \
	  --lua-filter=lua/listing.lua --lua-filter=lua/page.lua $(FLAGS) \
	  -M url=/$*/ -M kind=section -o $@ $<)

$(OUT)/index.html: $(SRCS) $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/home.html \
	  --lua-filter=lua/listing.lua --lua-filter=lua/page.lua $(FLAGS) \
	  -M url=/ -M kind=home -o $@ /dev/null)

$(OUT)/404.html: content/404.md $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/page.html $(NOTES) \
	  --lua-filter=lua/page.lua -M url=/404.html -M kind=page -o $@ $<)

$(OUT)/index.xml: $(SRCS) $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/rss.xml \
	  --lua-filter=lua/feed.lua $(FLAGS) -M selfpath=/index.xml -o $@ /dev/null)

# The same document, advertised at both addresses, so the self link differs.
$(OUT)/blog/index.xml: $(SRCS) $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/rss.xml \
	  --lua-filter=lua/feed.lua $(FLAGS) -M selfpath=/blog/index.xml -o $@ /dev/null)

$(OUT)/sitemap.xml: $(SRCS) $(DEPS)
	$(call pandoc-strict,$(PD) --template=templates/sitemap.xml \
	  --lua-filter=lua/sitemap.lua $(FLAGS) -o $@ /dev/null)

new:
	@test -n "$(t)" || { echo 'usage: make new t="Some Post"' >&2; exit 2; }
	@slug=$$(echo "$(t)" | tr 'A-Z' 'a-z' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$$//'); \
	  f="content/blog/$$slug.md"; \
	  test ! -e "$$f" || { echo "$$f exists" >&2; exit 1; }; \
	  printf -- '---\ntitle: %s\ndate: %s\ndraft: true\n---\n\n' \
	    "$(t)" "$$(date -u +%Y-%m-%d)" > "$$f"; \
	  echo "$$f"
