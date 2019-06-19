#/bin/sh!
set -o xtrace
curl https://get.pharo.org/64/stable+vm | bash
xvfb-run -a -e /dev/stdout ./pharo Pharo.image st --quit scripts/build/load.st
exit 0