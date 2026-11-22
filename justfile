# list the recipes
default:
    @just --list

# build the site into _site/
build:
    python3 build.py

# build, serve on http://localhost:<port>/ and rebuild on every change
dev port="8000":
    python3 build.py --serve {{port}}

# rebuild over a copy of the published site and list the files that would change
check:
    #!/usr/bin/env bash
    set -euo pipefail
    copy=$(mktemp -d)
    trap 'rm -rf "$copy"' EXIT
    git fetch --quiet origin gh-pages
    git archive origin/gh-pages | tar -x -C "$copy"
    python3 build.py --out "$copy" | sed "s#$copy#the published site#"

# remove the build output
clean:
    rm -rf _site
