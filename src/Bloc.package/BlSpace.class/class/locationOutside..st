debug - simulation
locationOutside: anElement
	"Return a random space location outside of element bounds"	
	| theBounds aPosition |
	
	anElement topMostParent forceLayout.
	theBounds := anElement bounds inSpace bounds.
	aPosition := {
		theBounds topRight - (theBounds width atRandom @ 100 atRandom).
		theBounds topRight + (100 atRandom @ theBounds height atRandom).
		theBounds bottomLeft + (theBounds width atRandom @ 100 atRandom).
		theBounds bottomLeft - (100 atRandom @ theBounds height atRandom).
	}	atRandom.
		
	self
		assert: [ (theBounds containsPoint: aPosition) not ]
		description: [ 'Point must be outside of the bounds' ].
		
	^ aPosition