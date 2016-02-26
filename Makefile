SSH_USER = kjhealy@kjhealy.co
DOCUMENT_ROOT = ~/public/plain-text.co/public_html
PUBLIC_DIR = public/
PREFIX = /Users/kjhealy/.pandoc
BIB = /Users/kjhealy/Documents/bibs/socbib-pandoc.bib
CSL = apsa

HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))


all: clean html

html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<')"

clean:
	$(RM) $(HTML_FILES)

public: html
	cp *.Rmd public/
	cp *.html public/
	cp styles.css public/
	cp -r libs public/
	cp -r figures public/
	find public -type d -print0 | xargs -0 chmod 755
	find public -type f -print0 | xargs -0 chmod 644

deploy: public
	rsync -crzve 'ssh -p 22' $(PUBLIC_DIR) $(SSH_USER):$(DOCUMENT_ROOT)

.PHONY: clean


