initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	scrollPosition := 0@0.

	self when: BlScrollEvent do: [ :anEvent |
		anEvent isScrollUp
			ifTrue: [ self flingBy: (0@500) ].
		anEvent isScrollDown
			ifTrue: [ self flingBy: (0@500) negated ].
		anEvent isScrollLeft
			ifTrue: [ self flingBy: (500@0) ].
		anEvent isScrollRight
			ifTrue: [ self flingBy: (500@0) negated ] ]