SSH_USER = kjhealy@kjhealy.co
DOCUMENT_ROOT = ~/public/plain-text.co/public_html
PUBLIC_DIR = public/
PREFIX = /Users/kjhealy/.pandoc
BIB = /Users/kjhealy/Documents/bibs/socbib-pandoc.bib
CSL = apsa

HTML_FILES := $(patsubst %.md, %.html ,$(wildcard *.md))


all: clean html

html: $(HTML_FILES)

%.html:	%.md
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -w html -S --toc --number-sections  --template=$(PREFIX)/templates/html-toc.template --css=css/kultiad-serif.css --filter pandoc-crossref --filter pandoc-citeproc --csl=$(PREFIX)/csl/$(CSL).csl --bibliography=$(BIB) -o $@ $<


clean:
	$(RM) $(HTML_FILES)

public: html
	cp *.md public/
	cp *.html public/
	cp -r css public/
	cp -r figures public/
	find public -type d -print0 | xargs -0 chmod 755
	find public -type f -print0 | xargs -0 chmod 644

deploy: public
	rsync -crzve 'ssh -p 22' $(PUBLIC_DIR) $(SSH_USER):$(DOCUMENT_ROOT)

.PHONY: clean
