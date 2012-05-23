-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

%.pdf: %.tex
	@echo $<: $$(sed -n '/^\\input/s/.*{\([^.]*\).*}.*/\1.tex/p' $<) > .dep/$<.d
	pdflatex $<

