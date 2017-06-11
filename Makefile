# LaTeX Makefile v1.0 -- LaTeX

CWD != pwd

#TEX_FILES = WIPresume.tex

#CONTENT_FILES  = $(TEX_FILES)
CONTENT_FILES  = contents/accomplishments.tex
CONTENT_FILES += contents/address.tex
CONTENT_FILES += contents/city.tex
CONTENT_FILES += contents/education.tex
CONTENT_FILES += contents/email.tex
CONTENT_FILES += contents/github.tex
CONTENT_FILES += contents/headline.tex
CONTENT_FILES += contents/interactive.tex
CONTENT_FILES += contents/linkedin.tex
CONTENT_FILES += contents/name.tex
CONTENT_FILES += contents/phone.tex
CONTENT_FILES += contents/profile.tex
CONTENT_FILES += contents/salesforce.tex
CONTENT_FILES += contents/searchsoft.tex
CONTENT_FILES += contents/stratice.tex
CONTENT_FILES += contents/zip.tex

PDFS = WIPresume.pdf

ALL_FILES = $(PDFS) $(CONTENT_FILES)
LATEX=pdflatex
PDFLATEX_FLAGS = -output-directory $(OUTPUT_DIR)
OUTPUT_DIR = ./tmp
CURRENT_FILE := $(.PARSEFILE)

#all:	## Make all targets
#all:	$(PDFS) TEMPS ## Make all targets
all:	$(PDFS)	 ## Make all targets
	#$(LATEX) $(MAIN)                # main run
	#$(LATEX) $(MAIN)                # incremental run
	#temps

clean:  ## Clean LaTeX and output figure files
	rm -rf tmp/*
	#-rm -f ${PDFS}.{ps,pdf,log,aux,out,dvi,bbl,blg}

TEMPS:  .USE	## Move log files to ./tmp
	-mv -f *.log ./tmp
	-mv -f *.aux ./tmp
	-mv -f *.dvi ./tmp
	-mv -f *.out ./tmp

$(PDFS): $(.PREFIX).tex $(CONTENT_FILES)
	$(LATEX) $(PDFLATEX_FLAGS) $(.PREFIX).tex
	-mv -f $(OUTPUT_DIR)/$(.TARGET) $(.TARGET)


watch:  ## Recompile on any update of LaTeX
	@while [ 1 ]; do              \
		inotifywait $(ALL_FILES); \
		sleep 0.01;               \
		make all;                 \
		echo "\n---------- \n";   \
		done

help:  # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html # modified for BSD
	@\grep -E '^[a-zA-Z_-]+:.*## .*$$' $(CURRENT_FILE) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

test:
	#echo $(MAIN)
	echo $(TEX_FILES)
	echo $(CONTENT_FILES)

.PHONY: help
#.PHONY: all clean temps watch help

.SUFFIXES: .pdf .tex
.tex.pdf:
	$(LATEX) $(.IMPSRC)
