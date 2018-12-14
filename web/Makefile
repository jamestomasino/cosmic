# Overridable Config
SRC_DIR ?= /var/gopher
DST_DIR ?= /var/www/html2
WEB_HEAD ?= /etc/templates/webheader.tmpl

ifeq ($(VERBOSE),1)
  MUTE :=
else
  MUTE := @
endif

htmlize := echo

# Canonical LISTING_FILE
LISTING_FILE := $(SRC_DIR)/listing.gophermap
LISTING_COUNT != wc -l $(LISTING_FILE) | awk '{print $$1}'
LISTING_LIST != awk -F '\t' '{gsub(" ","\\ ",$$2); gsub(".txt", "", $$2); gsub("^0", "", $$1); printf "<a href=\047%s.html\047>%s >> %s</a>\\n", $$2, $(LISTING_COUNT)-NR+1, $$1}' $(LISTING_FILE)
# Source TXT and transpiled HTML
SRC_TXT_FILES != awk -v src="$(SRC_DIR)" -F "\t" '{printf "%s%s\n", src, $$2}' "$(LISTING_FILE)" | sed 's|\ |\\ |g'
DST_HTML_FILES := $(SRC_TXT_FILES:$(SRC_DIR)/%.txt=$(DST_DIR)/%.html)

# Macros
copy = cp $< $@
mkdir = $(MUTE)mkdir -p $(dir $@)
addhead = $(MUTE)cat $(WEB_HEAD) > $@

.PHONY: all clean

all: $(DST_DIR)/log/index.html $(DST_HTML_FILES) $(DST_DIR)/error.html

clean:
	rm -rf $(DST_DIR)

$(DST_DIR)/error.html:
	$(mkdir)
	$(addhead)
	$(MUTE){ \
		printf "</head><body><div class=\"page-wrapper\"><pre class=\"inner-wrapper\"><a href=\"/\">&lt;&lt; BACK TO RELAY ONE</a>"; \
		printf "\\n\\n\\nERROR. TRANSMISSION NOT FOUND.</pre></div></body></html>"; \
	} >> $@

$(DST_DIR)/%.html: $(SRC_DIR)/%.txt
	$(mkdir)
	$(addhead)
	$(MUTE){\
		short_path=$$(printf "$<" | sed 's|^$(SRC_DIR)||' | sed 's|.txt||'); \
		log_title=$$(grep "$$short_path" "$(LISTING_FILE)" | head -1 | sed 's|^0||' | awk -F "\t" '{print $$1}'); \
		printf "<title>%s</title>\\n" "$$log_title"; \
		printf "<link rel=\"canonical\" href=\"https://cosmic.voyage%s.html\">\\n" "$$short_path"; \
		printf "</head>\\n<body>\\n<div class=\"page-wrapper\"><pre class=\"inner-wrapper\">\\n"; \
		printf "<a href=\"/log\">&lt;&lt; BACK TO RELAY ONE LOG</a>\\n\\n\\n"; \
		sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g' "$<"; \
		printf "</pre></div></body></html>"; \
	} >> $@

$(DST_DIR)/log/index.html: $(LISTING_FILE)
	$(mkdir)
	$(addhead)
	$(MUTE){\
		printf "<title>Cosmic Voyage - Transmission Log</title>"; \
		printf "<link rel=\"canonical\" href=\"https://cosmic.voyage/log\">"; \
		printf "</head>"; \
		printf "<body>"; \
		printf "<div class=\"page-wrapper\">"; \
		printf "<pre class=\"inner-wrapper\">"; \
		printf "<a href=\"/\">&lt;&lt; BACK TO RELAY ONE</a>\\n\\n"; \
		cat "$(SRC_DIR)/log/intro.gophermap"; \
	} >> $@
	$(MUTE)printf "$(LISTING_LIST)" >> $@
	$(MUTE){\
		printf "</pre>\\n"; \
		printf "</div>\\n"; \
		printf "</body>\\n"; \
		printf "</html>"; \
	} >> $@
