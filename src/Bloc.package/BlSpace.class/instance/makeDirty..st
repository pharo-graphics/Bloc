change reporting
makeDirty: aBlBounds

	self
		assert: [ aBlBounds isKindOf: BlBounds ]
		description: [ 'Only BlBounds can be used as dirty area' ].

	aBlBounds expanded.
	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aBlBounds copy ]
		ifNotEmpty: [ :aCollection | aCollection first merge: aBlBounds ].