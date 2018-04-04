pulse
doStep
	| shouldStartNext |
	
	(currentIndex > animations size)
		ifTrue: [ ^ self ].

	(currentIndex isZero and: [ animations isEmpty ])
		ifTrue: [ ^ self ].

	shouldStartNext := currentIndex isZero or: [ (animations at: currentIndex) isRunning not ].
			
	shouldStartNext ifTrue: [ 
		currentIndex := currentIndex + 1.
		
		"make sure we are not going out of bounds"
		(currentIndex > animations size)
			ifTrue: [ ^ self ].

		"(children at: currentIndex) initStart "].

	(animations at: currentIndex) run