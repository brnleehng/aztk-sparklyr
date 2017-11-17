#!/bin/bash
IFS='.' read -r -a baseVersion << $R_VERSION
curl -O https://cran.r-project.org/src/base/R-${baseVersion[0]}/R-$R_VERSION.tar.gz \