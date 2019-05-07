#!/bin/bash

set -euo pipefail

mkdir -p build && cd build

build() {
    # Configure
    cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug ..
    # Build (for Make on Unix equivalent to `make -j $(nproc)`)
    cmake --build . --config Debug -- -j $(nproc)
    # Test
    ctest -j $(nproc) --output-on-failure
}

do_coverage_report() {
    cmake --build . --config Debug -- ccov-all -j $(nproc)
}

run() {
  case "$TRAVIS_PHASE" in
    "build")
      build
      ;;
    "coverage-report")
      do_coverage_report
      ;;
  esac
}

run
