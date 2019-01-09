#/bin/sh!
set -o xtrace
echo $DISPLAY
export DISPLAY=:99.0
./pharo Pharo.image examples --junit-xml-output 'Bloc-Tests.*' 2>&1
./pharo Pharo.image test --junit-xml-output 'Bloc-Tests.*' 2>&1
exit 0