initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	
	self when: BlScrollEvent do: [ :anEvent |
		anEvent isScrollUp
			ifTrue: [ self scrollBy: (0@50) ].
		anEvent isScrollDown
			ifTrue: [ self scrollBy: (0@50) negated ].
		anEvent isScrollLeft
			ifTrue: [ self scrollBy: (50@0) ].
		anEvent isScrollRight
			ifTrue: [ self scrollBy: (50@0) negated ] ]