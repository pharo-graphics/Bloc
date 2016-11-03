dragboard managing
deleteDragboard
	| d |
	d := self dragboard.
	self dragboard clear.
	self dragboard: nil.
	^ d