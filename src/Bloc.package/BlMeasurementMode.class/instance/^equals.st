comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	^ anotherObject class == self class