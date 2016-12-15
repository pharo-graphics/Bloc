accessing
matchEvent: aKeyEvent
	self seqSize > 1 ifTrue: [ ^ false ].
	^ self sequence first matchEvent: aKeyEvent