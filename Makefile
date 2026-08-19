PORT := 8090
ROOMS := $(shell find . -maxdepth 1 -type d -not -path . -not -path ./.git -not -path ./.github -printf '%f\n')

.PHONY: run
run:
	python3 -m http.server $(PORT)

.PHONY: zip
zip:
	zip -r foto.zip $(ROOMS)
