initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	
	self when: BlScrollEvent do: [ :anEvent |
		anEvent isScrollUp
			ifTrue: [ self scrollFlinger smoothScrollBy: (0@20) ].
		anEvent isScrollDown
			ifTrue: [ self scrollFlinger smoothScrollBy: (0@20) negated ] ].