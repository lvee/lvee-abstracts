-include $(shell mkdir .dep 2>/dev/null) $(wildcard .dep/*)

all: 00.pdf

progress: .progress
	@$(MAKE) all | ./.progress

clean:
	rm -f $(shell tail -n +3 .hgignore | grep -v pdf)

.progress:
	@[ -x .progress ] || ( echo '#!/usr/bin/awk -f$$ $$ BEGIN {$$ a[0] = "/"$$ a[1] = "-"$$ a[2] = "\\\\"$$ a[3] = "|"$$ }$$ $$ {$$ printf "\010" a[(FNR - 1) % 4]$$ }$$ $$ END {$$ print "\010Done."$$ }$$' | sed 's,\$$,\n,g' > .progress ; chmod +x .progress )

%.pdf: %.tex
	@echo $@: $$(sed -n '/^\\input/s/.*{\([^.]*\).*}.*/\1.tex/p' $<) > .dep/$<.d
	pdflatex $<

.PHONY: all progress clean
