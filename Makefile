# LaTeX Makefile v1.0 -- LaTeX
# vim: set tabstop=4 shiftwidth=4 noexpandtab:

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
TXTS = $(PDFS:R).txt

ALL_FILES = $(PDFS) $(CONTENT_FILES)
LATEX=pdflatex
PDFLATEX_FLAGS = -output-directory $(OUTPUT_DIR)
PDFTOTEXT = pdftotext
PDFTOTEXT_FLAGS = -layout
OUTPUT_DIR = tmp/
CURRENT_FILE := $(.PARSEFILE)

#all:	## Make all targets
#all:	$(PDFS) TEMPS ## Make all targets
all:	$(PDFS)	 $(TXTS)  ## Make all targets
#all:	$(PDFS)  ## Make all targets

clean:  ## Clean LaTeX and output figure files
	rm -f $(OUTPUT_DIR)*
	#-rm -f ${PDFS}.{ps,pdf,log,aux,out,dvi,bbl,blg}

TEMPS:  .USE	## Move log files to ./tmp
	-mv -f *.log $(OUTPUT_DIR)
	-mv -f *.aux $(OUTPUT_DIR)
	-mv -f *.dvi $(OUTPUT_DIR)
	-mv -f *.out $(OUTPUT_DIR)

$(PDFS): $(.PREFIX).tex $(CONTENT_FILES)
	$(LATEX) $(PDFLATEX_FLAGS) $(.PREFIX).tex
	-mv -f $(OUTPUT_DIR)$(.TARGET) $(.TARGET)

$(TXTS): $(.PREFIX).pdf
	$(PDFTOTEXT) $(PDFTOTEXT_FLAGS) $(.PREFIX).pdf


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
	echo $(TXTS)

.PHONY: help
#.PHONY: all clean temps watch help

.SUFFIXES: .pdf .tex .txt
.tex.pdf:
	$(LATEX) $(.IMPSRC)

.pdf.txt:
	$(PDFTOTEXT) $(.IMPSRC)
