.PHONY: manual

manual:
	typst compile docs/manual.typ \
		--root . \
		manual.pdf
