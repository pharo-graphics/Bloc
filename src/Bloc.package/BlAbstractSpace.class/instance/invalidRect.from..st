change reporting
invalidRect: aSpartaRectangle from: anElement

	self dirtyAreas
		ifEmpty: [ self dirtyAreas add: aSpartaRectangle asRectangle ]
		ifNotEmpty: [ :aCollection | aCollection at: 1 put: (aSpartaRectangle merge: aCollection first) asRectangle ].

	self requestNextPulse