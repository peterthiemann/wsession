GOAL= main-icfp23-pearl
TARGET_MODULES= ST-finite-nonbranching ST-recursive ST-monadic ST-indexed-contextfree ST-multichannel Channels Utils
TARGET_FILES= agdamacros.tex unicodeletters.tex $(addprefix $(PREFIX)/, $(addsuffix .tex, $(TARGET_MODULES)))
PREFIX= latex

ZIPFILES= README.md $(addsuffix .lagda, $(TARGET_MODULES))
ZIPGOAL= supplement-icfp23.zip

ARXIVGOAL= $(GOAL).zip

$(GOAL).pdf: $(GOAL).tex $(TARGET_FILES)
	pdflatex  --synctex=1 -interaction=nonstopmode $(GOAL)

$(PREFIX)/%.tex: %.lagda
	agda --latex --only-scope-checking $<

$(ZIPGOAL): $(ZIPFILES)
	zip $@ $^

$(ARXIVGOAL): $(GOAL).tex $(GOAL).bbl $(TARGET_FILES) acmart.cls agda.sty ACM-Reference-Format.bst
	zip $@ $^

.PHONY: all
all: $(GOAL).pdf $(ZIPGOAL)

### executables

EX-multichannel: EX-multichannel.lagda
	agda --compile $^
