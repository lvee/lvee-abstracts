-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

ifeq ($(wildcard .progress),.progress)
.DEFAULT_GOAL := progress
endif

all: 00.pdf

progress: .progress
	@$(MAKE) all | ./.progress

clean:
	rm -f $(shell tail -n +3 .hgignore | grep -v pdf)

.progress:
	@[ -x .progress ] || ( echo '#!/usr/bin/awk -f$$$$BEGIN {$$a[0] = "/"$$a[1] = "-"$$a[2] = "\\"$$a[3] = "|"$$pass = 0$$}$$$${$$if (!pass) printf "" a[(FNR - 1) % 4]$$else print$$}$$$$/pdflatex|ONEXIT/ {$$if (!pass) printf ". "$$}$$$$/^!/ {$$pass = 1$$print ""$$print$$}$$$$END {$$if (!pass) print "Done."$$}$$$$' | tr $$ \\n > .progress ; chmod +x .progress )

%.pdf: %.tex
	@echo $@: $$(sed -n '/^\\input/s/.*{\([^.]*\).*}.*/\1.tex/p' $<) > .dep/$<.d
	pdflatex $<
	pdflatex $<
	pdflatex $<

.PHONY: all progress clean
