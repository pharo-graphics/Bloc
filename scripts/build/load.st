"load latest version"
EpMonitor current disable.

NonInteractiveTranscript stdout show: '...Bloc Loading was here...'; cr.
"Metacello new
  baseline: 'Bloc';
  repository: 'github://pharo-graphics/Bloc/src';
  load.
 "
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
