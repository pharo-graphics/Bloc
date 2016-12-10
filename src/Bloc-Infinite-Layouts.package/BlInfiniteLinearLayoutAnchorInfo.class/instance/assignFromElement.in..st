initialization
assignFromElement: anElement in: aLinearLayout
	| anOrientation |
	anOrientation := aLinearLayout orientation.
	
	coordinate := layoutFromEnd
		ifTrue: [ (anOrientation decoratedEnd: anElement) + anOrientation totalSpaceChange ]
		ifFalse: [ anOrientation decoratedStart: anElement ].

	position := aLinearLayout childPositionOf: anElement