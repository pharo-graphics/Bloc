computing group bounds
groupBounds
	
	groupBounds
		ifNil: [ groupBounds := self createGroupBounds ].
	
	groupBoundsValid ifFalse: [ 
		self computeGroupBounds.
		groupBoundsValid = true ].
	
	^ groupBounds