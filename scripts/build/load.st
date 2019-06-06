"load latest version"
EpMonitor current disable.

Metacello new
  baseline: 'Bloc';
  repository: 'github://pharo-graphics/Bloc/src';
  load.

Metacello new
   baseline: 'GToolkitExamples';
   repository: 'github://feenkcom/gtoolkit-examples/src';
   load.
   
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
