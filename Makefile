%.pdf: %.ps
	ps2pdf $<

%.ps: %.dvi
	dvips $<

%.dvi: %.tex
	latex $<
