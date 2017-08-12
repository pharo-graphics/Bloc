mouse handlers
scrollEvent: anEvent
	| dX dY anAmount |
	
	anAmount := 600.

	dX := anEvent isScrollLeft
		ifTrue: [ anAmount ]
		ifFalse: [ anEvent isScrollRight
			ifTrue: [ anAmount negated ]
			ifFalse: [ 0 ] ].

	dY := anEvent isScrollDown
		ifTrue: [ anAmount ]
		ifFalse: [ anEvent isScrollUp
			ifTrue: [ anAmount negated ]
			ifFalse: [ 0 ] ].
	
	anEvent currentTarget fling: dX @ dY.
	
	anEvent consumed: true