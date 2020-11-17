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
	mv _book public
	cp -r assets/envision/css public/
	cp -r assets/envision/js public/
	cp -r assets/envision/font public/
	cp assets/pushy/css/normalize.css public/css
	cp assets/css/toc.css public/css
	cp assets/css/sourcesans.css public/css
	cp assets/css/tufte.css public/libs/tufte-css-2015.12.29/
	cd public && perl -p -i -e 's/oORLOo/<code>/g' *.html
	cd public && perl -p -i -e 's/oORROo/<\/code>/g' *.html
	cd public && perl -p -i -e 's/<div class="sourceCode">/<p class="sourceCode">/g' *.html
	cd public && perl -p -i -e 's/<\/pre><\/div>/<\/pre><\/p>/g' *.html

pdf:
	Rscript --quiet -e "bookdown::render_book('index.Rmd', 'bookdown::tufte_book2')"
	cp -r figures _book/
	cp -r _bookdown_files/_main_files _book/
	cd _book && pdflatex _main.tex
	cd _book && pdflatex _main.tex
	cd _book && pdflatex _main.tex
	cd _book && pdflatex _main.tex
	cd _book && mv _main.pdf plain-person-text.pdf


xepdf:
	Rscript --quiet -e "bookdown::render_book('index.Rmd', 'bookdown::tufte_book2')"
	cp -r figures _book/
	cp -r _bookdown_files/_main_files _book/
	cd _book && xelatex _main.tex
	cd _book && xelatex _main.tex
	cd _book && xelatex _main.tex
	cd _book && xelatex _main.tex
	cd _book && mv _main.pdf plain-person-text.pdf


clean:
	$(RM) $(HTML_FILES)
	rm -rf _book/
	rm -rf public/
	rm -f _main*
	rm -rf _bookdown_files/

public: tufte
	cp *.Rmd public/
	cp favicon.ico public/
	cd public && mv 01-record.Rmd keep-a-record.Rmd
	cd public && mv 02-edit.Rmd write-and-edit.Rmd
	cd public && mv 03-reproduce.Rmd reproduce-word.Rmd
	cd public && mv 04-make.Rmd pull-it-together.Rmd
	cd public && mv 04-the-esk.Rmd an-emacs-starter-kit.Rmd
	cd public && mv 05-pros.Rmd do-i-have-to-use-this-stuff.Rmd
	cd public && mv 06-links.Rmd links-to-other-resources.Rmd
	find public -type d -print0 | xargs -0 chmod 755
	find public -type f -print0 | xargs -0 chmod 644

deploy: public pdf
	cp _book/plain-person-text.pdf public/
	rsync -crzve 'ssh -p 22' $(PUBLIC_DIR) $(SSH_USER):$(DOCUMENT_ROOT)

.PHONY: clean


