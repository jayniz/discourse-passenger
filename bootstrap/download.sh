#!/bin/sh
url=https://github.com/discourse/discourse/tarball/${DISCOURSE_VERSION}
echo "Downloading ${url}"
curl -s -L $url | tar xzf - -C $(pwd) --strip-components=1
