accessing
orientation: anInfiniteLayoutOrientation

	self
		assert: [ anInfiniteLayoutOrientation isNotNil ]
		description: [ 'Orientation must not be nil' ].
	
	self assertNotInLayoutOrScroll.
	
	"Clean state of previous orientation"
	orientation ifNotNil: #reset.
	
	orientation := anInfiniteLayoutOrientation.
	orientation reset.
	orientation layout: self.

	self requestLayout