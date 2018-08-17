mouse handlers
scrollEvent: anEvent
	| dX dY anAmount anInfiniteElement didFling |
	
	anAmount := 300.
	
	anInfiniteElement := anEvent currentTarget.

	dX := anEvent isHorizontal
		ifTrue: [ anAmount * anEvent vector x sign ]
		ifFalse: [ 0 ].

	dY := (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
		ifTrue: [ anAmount ]
		ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
			ifTrue: [ anAmount negated ]
			ifFalse: [ 0 ] ].

	didFling := anEvent currentTarget fling: dX @ dY.
	anEvent consumed: didFling