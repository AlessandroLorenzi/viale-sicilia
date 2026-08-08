PORT := 8090

.PHONY: run
run:
	python3 -m http.server $(PORT)
