DISCOURSE_REVISION := "v1.8.8"
.PHONY: build

default: build

clean:
	hooks/post_build

build:
	hooks/pre_build
	DISCOURSE_REVISION=$(DISCOURSE_REVISION) hooks/build

push:
	docker push jannis/discourse-passenger
