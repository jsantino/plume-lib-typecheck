#!/bin/bash
ROOT=$TRAVIS_BUILD_DIR/..

# Fail the whole script if any command fails
set -e

## Build Checker Framework
(cd $ROOT && git clone https://github.com/gyhughes/checker-framework.git)
# This also builds annotation-tools and jsr308-langtools
(cd $ROOT/checker-framework/ && ./.travis-build-without-test.sh)
export CHECKERFRAMEWORK=$ROOT/checker-framework

## Obtain plume-lib
(cd $ROOT && git clone https://github.com/plume-lib-check-index.git)

make -C $ROOT/plume-lib/java JAVACHECK_ARGS="-source 7 -target 7 -Xlint:-options -Awarns -implicit:class -Xlint:-processing -AcheckPurityAnnotations -processor org.checkerframework.checker.index.IndexChecker" check-types

