"load latest version"
EpMonitor current disable.

IceCredentialsProvider sshCredentials
	publicKey: '';
	privateKey: ''.

IceCredentialsProvider useCustomSsh: false.

Metacello new
  baseline: 'Bloc';
  repository: 'github://feenkcom/Bloc/src';
  load.
EpMonitor current enable.
Smalltalk snapshot: true andQuit: false.
