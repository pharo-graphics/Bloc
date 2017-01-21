change reporting
invalidRect: aSpartaRectangle from: anElement

	aSpartaRectangle expanded.
	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aSpartaRectangle copy ]
		ifNotEmpty: [ :aCollection | aCollection first merge: aSpartaRectangle ].

	self requestNextPulse