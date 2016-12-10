instance creation
bindHolder: anElementHolder at: aPosition

	anElementHolder position: aPosition.
	self hasStableIds
		ifTrue: [ anElementHolder itemId: (self itemIdAt: aPosition) ].
	anElementHolder flags
		clearUpdate;
		clearInvalid;
		clearDataSourcePositionUnknown;
		addBound.

	self onBindHolder: anElementHolder at: aPosition.
	anElementHolder clearPayload.
	anElementHolder itemElement constraints infinite insetsDirty: true