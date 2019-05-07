#!/bin/bash

set -euo pipefail

mkdir -p build && cd build

build() {
    # Configure
    cmake -DENABLE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug ..
    # Build (for Make on Unix equivalent to `make -j $(nproc)`)
    cmake --build . --config Debug -- -j $(nproc)
    # Test
    ctest -j $(nproc) --output-on-failure
}

do_coverage_report() {
    # Create lcov report
    # capture coverage info
    lcov --directory . --capture --output-file coverage.info
    # filter out system and extra files.
    # To also not include test code in coverage add them with full path to the patterns: '*/tests/*'
    lcov --remove coverage.info '/usr/*' "${HOME}"'/.cache/*' --output-file coverage.info
    # output coverage data for debugging (optional)
    lcov --list coverage.info
    # Uploading to CodeCov
    # '-f' specifies file(s) to use and disables manual coverage gathering and file search which has already been done above
    bash <(curl -s https://codecov.io/bash) -f coverage.info || echo "Codecov did not collect coverage reports"
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
