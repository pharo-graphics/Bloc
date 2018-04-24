comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ anotherObject isAbsolute = self isAbsolute