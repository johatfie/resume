# LaTeX Makefile v1.0 -- LaTeX

CWD != pwd
#ALL=$(wildcard *.tex contents/*.tex)
#MAIN=WIPresume.tex
#MAIN=$(wildcard *.tex)
#MAIN=$(*.tex)

#TEX_FILES = $(shell find . -name '*.tex' -or -name '*.sty' -or -name '*.cls')
#TEX_FILES != find . -name '*.tex' -or -name '*.sty' -or -name '*.cls'
TEX_FILES = WIPresume.tex

ALL_FILES  = $(TEX_FILES)
ALL_FILES += contents/accomplishments.tex
ALL_FILES += contents/address.tex
ALL_FILES += contents/city.tex
ALL_FILES += contents/education.tex
ALL_FILES += contents/email.tex
ALL_FILES += contents/github.tex
ALL_FILES += contents/headline.tex
ALL_FILES += contents/interactive.tex
ALL_FILES += contents/linkedin.tex
ALL_FILES += contents/name.tex
ALL_FILES += contents/phone.tex
ALL_FILES += contents/profile.tex
ALL_FILES += contents/salesforce.tex
ALL_FILES += contents/searchsoft.tex
ALL_FILES += contents/stratice.tex
ALL_FILES += contents/zip.tex


LATEX=pdflatex
#LATEX=latex
#SHELL=/usr/local/bin/bash
CURRENT_FILE := $(.PARSEFILE)

#all:	## Make all targets
all:	$(TEX_FILES) TEMPS ## Make all targets
	#$(LATEX) $(MAIN)                # main run
	#$(LATEX) $(MAIN)                # incremental run
	#temps

clean:  ## Clean LaTeX and output figure files
	rm -rf tmp/

TEMPS:  .USE	## Move log files to ./tmp
	#ls *.log 1> /dev/null 2>&1 && mv -f *.log ./tmp
	#ls *.aux 1> /dev/null 2>&1 && mv -f *.aux ./tmp
	#ls *.dvi 1> /dev/null 2>&1 && mv -f *.dvi ./tmp
	#ls *.out 1> /dev/null 2>&1 && mv -f *.out ./tmp
	#mv -f *.log ./tmp 1> /dev/null 2>&1
	#mv -f *.aux ./tmp 1> /dev/null 2>&1
	#mv -f *.dvi ./tmp 1> /dev/null 2>&1
	#mv -f *.out ./tmp 1> /dev/null 2>&1
	#for x in ./*.dvi; do  mv -f x ./tmp; done
	#@if ls *.log 1> /dev/null 2>&1; then mv -f *.log ./tmp; fi
	#@if ls *.aux 1> /dev/null 2>&1; then mv -f *.aux ./tmp; fi
	#@if ls *.dvi 1> /dev/null 2>&1; then mv -f *.dvi ./tmp; fi
	#@if ls *.out 1> /dev/null 2>&1; then mv -f *.out ./tmp; fi
	-mv -f *.log ./tmp
	-mv -f *.aux ./tmp
	-mv -f *.dvi ./tmp
	-mv -f *.out ./tmp

$(TEX_FILES):
	#echo $(LATEX) $(.TARGET)
	#$(LATEX) $(.TARGET)
	echo $(LATEX) $(.TARGET)
	$(LATEX) $(.TARGET)

watch:  ## Recompile on any update of LaTeX
	@while [ 1 ]; do           \
		inotifywait $(ALL);    \
		sleep 0.01;            \
		make all;              \
		echo "\n----------\n"; \
		done

help:  # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html # modified for BSD
	@\grep -E '^[a-zA-Z_-]+:.*## .*$$' $(CURRENT_FILE) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

test: 
	#echo $(MAIN)
	echo $(TEX_FILES)

#.DEFAULT_GOAL := help
.PHONY: help
#.PHONY: all clean temps watch help

