accessing
stop
	pulseListeners do: [ :each | each clear ].
		
	[ self pulseLoop isRunning
		ifTrue: [ self pulseLoop stop ] ]
			"Otherwise host will not be stopped"
			ensure: [ self host stop ]