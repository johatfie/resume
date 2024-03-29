# vim: set tabstop=4 shiftwidth=4 noexpandtab:

CWD != pwd

CONTENT_FILES  = contents/ININ_software_engineer.tex
CONTENT_FILES += contents/ININ_support_software_engineer.tex
CONTENT_FILES += contents/accomplishments.tex
CONTENT_FILES += contents/address.tex
CONTENT_FILES += contents/appriss_health.tex
CONTENT_FILES += contents/calsaws.tex
CONTENT_FILES += contents/city.tex
CONTENT_FILES += contents/developertown.tex
CONTENT_FILES += contents/education.tex
CONTENT_FILES += contents/email.tex
CONTENT_FILES += contents/github.tex
CONTENT_FILES += contents/headline.tex
CONTENT_FILES += contents/interactive.tex
CONTENT_FILES += contents/kroger.tex
CONTENT_FILES += contents/linkedin.tex
CONTENT_FILES += contents/name.tex
CONTENT_FILES += contents/nike.tex
CONTENT_FILES += contents/phone.tex
CONTENT_FILES += contents/pizza_restaurant
CONTENT_FILES += contents/profile.tex
CONTENT_FILES += contents/revcontent.tex
CONTENT_FILES += contents/salesforce.tex
CONTENT_FILES += contents/sandata.tex
CONTENT_FILES += contents/searchsoft.tex
CONTENT_FILES += contents/stratice.tex
CONTENT_FILES += contents/the_cellular_connection.tex
CONTENT_FILES += contents/widgets_are_us.tex
CONTENT_FILES += contents/zip.tex

PDFS   = JonHatfieldResume.pdf
PDFS  += JonHatfieldPublicResume.pdf
PDFS  += JonHatfieldPublicResume_watermarked.pdf
TXTS   = $(PDFS:S/pdf/txt/g)

RESUME_TEX      = resume.tex
ALL_FILES       = $(PDFS) $(CONTENT_FILES)
LATEX           = pdflatex
PDFLATEX_FLAGS  = -output-directory $(OUTPUT_DIR) --jobname $(.PREFIX)
PDFTOPNG        = /usr/local/libexec/xpdf/pdftopng
PDFTOPNG_FLAGS  = -r 80
PDFTOTEXT       = /usr/local/libexec/xpdf/pdftotext
#PDFTOTEXT       = /usr/local/bin/pdftotext
PDFTOTEXT_FLAGS = -layout
OUTPUT_DIR      = tmp
CURRENT_FILE   := $(.PARSEFILE)

all:	vc	 $(PDFS)	 $(TXTS)	png  ## Make all targets
#all:	vc	 $(PDFS)	png  ## Make all targets		pdftotext is unavailable on brew

clean:  ## Clean LaTeX and output figure files
	rm -f $(OUTPUT_DIR)/* $(PDFS) $(TXTS) vc.tex *.png *.zip
	#-rm -f ${PDFS}.{ps,pdf,log,aux,out,dvi,bbl,blg}

#$(PDFS): $(.PREFIX).tex $(CONTENT_FILES)
$(PDFS): $(RESUME_TEX) $(CONTENT_FILES)
	#$(LATEX) $(PDFLATEX_FLAGS) $(.PREFIX).tex
	$(LATEX) $(PDFLATEX_FLAGS) $(RESUME_TEX)
	-mv -f $(OUTPUT_DIR)/$(.TARGET) $(.TARGET)

$(TXTS): $(.PREFIX).pdf
	$(PDFTOTEXT) $(PDFTOTEXT_FLAGS) $(.PREFIX).pdf

vc:  ## Rebuild git infomation
	@echo
	@echo Rebuilding git information file vc.tex
	@echo
	@\./vc

png:  ## Create watermarked images
	@echo Creating recruiter preview version
	$(PDFTOPNG) $(PDFTOPNG_FLAGS) JonHatfieldPublicResume_watermarked.pdf JonHatfieldPublicResume_watermarked
	zip JonHatfieldPublicResume_watermarked.zip *.png
	mv JonHatfieldPublicResume_watermarked*.png $(OUTPUT_DIR)

watch:  ## Recompile on any update of LaTeX files
	@while [ 1 ]; do              \
		inotifywait $(ALL_FILES); \
		sleep 0.01;               \
		make all;                 \
		echo;                     \
		echo "----------";        \
		echo;                     \
		done

help:  # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html # modified for BSD
	@\grep -E '^[a-zA-Z_-]+:.*## .*$$' $(CURRENT_FILE) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

debug:  ## Show variables
	@echo
	@echo "CONTENT_FILES: $(CONTENT_FILES)"
	@echo
	@echo "PDFS: $(PDFS)"
	@echo
	@echo "TXTS: $(TXTS)"
	@echo

.PHONY: help test watch vc
#.PHONY: all clean temps watch help

.SUFFIXES: .pdf .tex .txt
.tex.pdf:
	$(LATEX) $(.IMPSRC)

.pdf.txt:
	$(PDFTOTEXT) $(.IMPSRC)
