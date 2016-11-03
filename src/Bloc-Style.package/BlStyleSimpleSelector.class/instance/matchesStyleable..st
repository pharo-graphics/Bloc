testing
matchesStyleable: aStyleable
	self matchesOnName
		ifTrue: [ (self nameMatches: aStyleable className) ifFalse: [ ^ false ] ].
	self matchesOnId
		ifTrue: [self id = aStyleable styleId ifFalse: [ ^ false ] ].
	self matchesOnStyleClass
		ifTrue:[(self matchesStyleClasses: aStyleable styleClasses ) ifFalse: [ ^ false ] ].
	^ true