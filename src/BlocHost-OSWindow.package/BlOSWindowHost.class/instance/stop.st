host - api
stop
	"Attempt to stop OSWindow driver.
	Note: Since OSWindow can be used independent of bloc we should not stop driver
	if it was running before bloc space was opened"
	
	wasRunning
		ifTrue: [ ^ self ].
		
	self
		assert: [ self isRunning ]
		description: [ 'OSWindow host must be running in order to be stopped' ].

	OSWindowDriver current reset