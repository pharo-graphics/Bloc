#/bin/sh!
set -o xtrace
xvfb-run -a -e /dev/stdout ./pharo Pharo.image examples --junit-xml-output 'Bloc.*' 2>&1
xvfb-run -a -e /dev/stdout ./pharo Pharo.image test --junit-xml-output 'Bloc.*' 2>&1
exit 0
