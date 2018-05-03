initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	scrollPosition := 0@0.

	self
		when: BlMouseWheelEvent
		do: [ :anEvent | self scrollBy: anEvent vector * 20 ]