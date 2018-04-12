comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject from = self from
		and: [ anotherObject to = self to ]