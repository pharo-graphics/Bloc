accessing
stop
	pulseListeners do: [ :each | each clear ].
		
	[ self pulseLoop isRunning
		ifTrue: [ self pulseLoop stop ] ]
			"Otherwise host will not be stopped"
			ensure: [ self allSpacesDo: [ :aSpace | aSpace host isRunning ifTrue: [ aSpace host stop ] ] ]