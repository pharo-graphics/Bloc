#!/bin/bash
set -x
set -e

# Define SCRIPTS_DIR and REPO_DIR in a way this script can
# be executed:
#   * from any directory
#   * from linux, macos, and windows (with mingw64)
case "$(uname -s)" in
   MINGW*)
     SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd -W )"
     ;;
   *)
     SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
     ;;
esac
REPO_DIR="$(dirname "$SCRIPTS_DIR")"

# Get a fresh image and load code
curl https://get.pharo.org/64/100+vmLatest | bash
./pharo Pharo.image eval --save "EpMonitor current disable"
./pharo Pharo.image metacello install "tonel://$REPO_DIR/src" BaselineOfNewBloc
./pharo Pharo.image eval --save "EpMonitor current enable"
