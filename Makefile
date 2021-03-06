VERSION := "1.9.7"
.PHONY: build

default: build

clean:
	hooks/post_build

build:
	hooks/pre_build
	DISCOURSE_VERSION=v$(VERSION) TAG=$(VERSION) hooks/build
	make clean

push:
	docker push jannis/discourse-passenger:$(VERSION)
