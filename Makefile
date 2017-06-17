SSH_USER = kjhealy@kjhealy.co
DOCUMENT_ROOT = ~/public/plain-text.co/public_html
PUBLIC_DIR = public/
PREFIX = /Users/kjhealy/.pandoc
BIB = /Users/kjhealy/Documents/bibs/socbib-pandoc.bib
CSL = apsa

HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))


all: deploy

html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<')"
	proc-panweb.sh $@

tufte: 
	Rscript --quiet -e "bookdown::render_book('index.Rmd', 'bookdown::tufte_html_book')"
	cp -r assets/envision/css public/
	cp -r assets/envision/js public/
	cp -r assets/envision/font public/
	cp assets/pushy/css/normalize.css public/css
	cp assets/toc.css public/css/toc.css
	cp assets/css/sourcesans.css public/css/sourcesans.css
	cp assets/css/tufte.css public/libs/tufte-css-2015.12.29/
	cd public && perl -p -i -e 's/oORLOo/<code>/g' *.html
	cd public && perl -p -i -e 's/oORROo/<\/code>/g' *.html
	cd public && perl -p -i -e 's/<div class="sourceCode">/<p class="sourceCode">/g' *.html
	cd public && perl -p -i -e 's/<\/pre><\/div>/<\/pre><\/p>/g' *.html


clean:
	$(RM) $(HTML_FILES)
	rm -rf _book/
	rm -rf public/

public: tufte
	cp *.Rmd public/
	cp favicon.ico public/
	find public -type d -print0 | xargs -0 chmod 755
	find public -type f -print0 | xargs -0 chmod 644

deploy: public
	rsync -crzve 'ssh -p 22' $(PUBLIC_DIR) $(SSH_USER):$(DOCUMENT_ROOT)

.PHONY: clean


