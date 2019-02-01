"load latest version"
EpMonitor current disable.

Metacello new
  baseline: 'Bloc';
  repository: 'github://feenkcom/Bloc/src';
  load.
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
