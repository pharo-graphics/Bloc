initialization
initialize
	super initialize.

	scrollFlinger := BlScrollFlinger on: self.
	scrollPosition := 0@0.
	scrollState := #idle.
	horizontalAlignment := self defaultHorizontalAlignment.
	verticalAlignment := self defaultVerticalAlignment.

	self
		when: BlMouseWheelEvent
		do: [ :anEvent | self scrollBy: anEvent vector * 20 ]