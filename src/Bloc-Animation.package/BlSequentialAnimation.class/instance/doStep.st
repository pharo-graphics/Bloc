pulse
doStep
	| shouldStartNext |
	
	(currentIndex > children size)
		ifTrue: [ ^ self ].

	(currentIndex isZero and: [ children isEmpty ])
		ifTrue: [ ^ self ].

	shouldStartNext := currentIndex isZero or: [ (children at: currentIndex) isRunning not ].
			
	shouldStartNext ifTrue: [ 
		currentIndex := currentIndex + 1.
		
		"make sure we are not going out of bounds"
		(currentIndex > children size)
			ifTrue: [ ^ self ].

		(children at: currentIndex) initStart ].

	(children at: currentIndex) pulse