#!/bin/bash
IFS='.' read majorVersion minorVersion patchVersion <<< $1
curl -O https://cran.r-project.org/src/base/R-${majorVersion}/R-$1.tar.gz \