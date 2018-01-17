comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	^ anotherObject isKindOf: self class