host - api
start
	"Attempt to start OSWindow driver if it is not running yet.
	Note: Since OSWindow may be used independent of Bloc we should remember
	if environment was running in order to not stop when bloc space is getting closed"

	wasRunning := self isRunning.
	wasRunning
		ifTrue: [ ^ self ].

	OSWindowDriver current