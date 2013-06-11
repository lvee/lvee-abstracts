all:
	pdflatex concatenative.tex
	bibtex concatenative.aux
	pdflatex concatenative.tex
	pdflatex concatenative.tex
	evince concatenative.pdf

clean:
	rm -f *.aux *.log *.toc *.bbl *.blg *.out
