# vim: set tabstop=4 shiftwidth=4 noexpandtab:

CWD != pwd


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

PDFS   = JonHatfieldResume.pdf
PDFS  += JonHatfieldPublicResume.pdf
TXTS   = $(PDFS:S/pdf/txt/g)

RESUME_TEX 		= resume.tex
ALL_FILES       = $(PDFS) $(CONTENT_FILES)
LATEX           = pdflatex
PDFLATEX_FLAGS  = -output-directory $(OUTPUT_DIR) --jobname $(.PREFIX)
PDFTOTEXT       = /usr/local/libexec/xpdf/pdftotext
PDFTOTEXT_FLAGS = -layout
OUTPUT_DIR      = tmp
CURRENT_FILE   := $(.PARSEFILE)

all:	vc	 $(PDFS)	 $(TXTS)  ## Make all targets

clean:  ## Clean LaTeX and output figure files
	rm -f $(OUTPUT_DIR)/* $(PDFS) $(TXTS) vc.tex
	#-rm -f ${PDFS}.{ps,pdf,log,aux,out,dvi,bbl,blg}

#$(PDFS): $(.PREFIX).tex $(CONTENT_FILES)
$(PDFS): $(RESUME_TEX) $(CONTENT_FILES)
	#$(LATEX) $(PDFLATEX_FLAGS) $(.PREFIX).tex
	$(LATEX) $(PDFLATEX_FLAGS) $(RESUME_TEX)
	-mv -f $(OUTPUT_DIR)/$(.TARGET) $(.TARGET)

$(TXTS): $(.PREFIX).pdf
	$(PDFTOTEXT) $(PDFTOTEXT_FLAGS) $(.PREFIX).pdf

vc:  ## Rebuild git infomation
	echo Rebuilding git information file vc.tex
	@\./vc


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
	echo $(CONTENT_FILES)
	echo $(PDFS)
	echo $(TXTS)

.PHONY: help test watch vc
#.PHONY: all clean temps watch help

.SUFFIXES: .pdf .tex .txt
.tex.pdf:
	$(LATEX) $(.IMPSRC)

.pdf.txt:
	$(PDFTOTEXT) $(.IMPSRC)
