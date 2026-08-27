PORT := 8090

.PHONY: run
run:
	python3 -m http.server $(PORT)

.PHONY: zip
zip:
	zip -r foto.zip FOTO/ROOMS

.PHONY: thumbnail
thumbnail:
	./scripts/generate-thumbnails.sh
