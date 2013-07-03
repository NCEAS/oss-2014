RM = rm -f
CP = cp
TOUCH = touch
REXE = R --vanilla
RCMD = $(REXE) CMD
RSCRIPT = Rscript --vanilla

CC = gcc
CXX = g++
CFLAGS = -O4 -Wall
CXXFLAGS = -O4 -Wall
LDLIBS =
FC = gfortran
FFLAGS = -O4
INSTALL = install

LATEX = latex
PDFLATEX = pdflatex
BIBTEX = bibtex
MAKEIDX = makeindex

DVIPS = dvips -tletter -Ppdf
PSTOPDF = ps2pdf
EPSTOPDF = epstopdf
TTH = htlatex # tth -E2 -e2
TTM = ttm -E2 -e2


CSS=/usr/local/lib/R/site-library/markdown/resources/markdown.css	

default:

.PHONY:

allhtml: datavis.html datavis_lab.html mixedlab1.html mixed1.html mixed2.html mixed3.html mixed4.html schedule.html

allpdf: datavis.pdf datavis_lab.pdf mixedlab1.pdf mixed1.pdf mixed2.pdf mixed3.pdf mixed4.pdf schedule.pdf

%.md: %.rmd
	$(RSCRIPT) -e "library(knitr); knit(\"$*.rmd\")"

%.pdf: %.md
	pandoc -f "markdown-implicit_figures" -s --bibliography=analysis.bib -o $*.tex $*.md; ./svhack $*.tex >tmp.tex; pdflatex tmp.tex; mv tmp.pdf $*.pdf

%.html: %.md
	pandoc -f "markdown-implicit_figures" -s -o $*.html -c ${CSS} $*.md --self-contained --bibliography analysis.bib --mathml
##	pandoc --bibliography=glmm.bib -o $*.html $*.md
##	$(RSCRIPT) -e "library(markdown); markdownToHTML(\"$*.md\",output=\"$*.html\")"

## Pandoc vs Sundown markdown differences:
##  citations, footnotes (N/A in Sundown)
##  nested list (4 spaces for Pandoc, 1 space for Sundown)
##  blank line before blockquotes, bulleted lists in Pandoc
##  citation tags with special characters (:,+) problematic?
##  why is @augustin_quantile_2012 still problematic???
##     @augustin_quantil_2012 seems to works.  21-char length limit??
##     need to test from scratch
##  math rendering: no mathjax with self-contained; latexmathml screws up ...
##   jsmath not self-contained; mathml seems OK

%.tex: %.Rnw
##	$(RSCRIPT) -e "library(cacheSweave); Sweave(\"$*.Rnw\",driver=cacheSweaveDriver);"
	$(RSCRIPT) -e "library(knitr); knit(\"$*.Rnw\")"

%.tex: %.txt
	pandoc -s -o $*.tex $*.txt

%.R: %.Rnw
	$(RCMD) Stangle $*

%.pdf: %.tex
	$(PDFLATEX) $*
	-$(BIBTEX) $*
	$(PDFLATEX) $*
	$(PDFLATEX) $*

%.pdf: %.ps
	$(PSTOPDF) $*.ps $@

%.ps: %.dvi
	$(DVIPS) $*.dvi -o $@

%.html: %.tex
	$(TTH) $*

%.xml: %.tex
	$(TTM) $*

%.pdf: %.fig
	$(F2D) -Lpdf $*.fig $@

%.pdf: %.eps
	$(EPSTOPDF) $*.eps --outfile=$*.pdf

%.eps: %.fig
	$(F2D) -Leps $*.fig $@

%.png: %.fig
	$(F2D) -Lpng $*.fig $@

%.bbl: %.tex
	-$(LATEX) $*
	$(BIBTEX) $*

%.idx: %.tex
	-$(LATEX) $*

%.ind: %.idx
	$(MAKEIDX) $*

%: %.cc
	$(CXX) $(CXXFLAGS) $*.cc $(LDLIBS) -o $*

%: %.c
	$(CC) $(CFLAGS) $*.c $(LDLIBS) -o $*

%: %.f
	$(FC) $(FFLAGS) $*.f $(LDLIBS) -o $*

clean:
	$(RM) *.o *.tex *.log *.aux *.toc *.blg *.bbl *.out *-???.pdf Rplots.ps

.SECONDARY:
