initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	
	self when: BlScrollEvent do: [ :anEvent |
		anEvent isScrollUp
			ifTrue: [ self smoothScrollBy: (0@50) ].
		anEvent isScrollDown
			ifTrue: [ self smoothScrollBy: (0@50) negated ] ].