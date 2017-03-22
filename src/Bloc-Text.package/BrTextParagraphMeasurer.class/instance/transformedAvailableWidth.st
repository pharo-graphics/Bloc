geometry - accessing
transformedAvailableWidth
	^ self hasTransformation
		ifTrue: [ self shouldBeImplemented "(self inverseTransformation transformX: self availableWidth) - self transformation translation x" ]
		ifFalse: [ self availableWidth ]