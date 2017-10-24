DISCOURSE_VERSION := "v1.8.8"
.PHONY: build

default: build

clean:
	hooks/post_build

build:
	hooks/pre_build
	DISCOURSE_VERSION=$(DISCOURSE_VERSION) hooks/build

push:
	docker push jannis/discourse-passenger
