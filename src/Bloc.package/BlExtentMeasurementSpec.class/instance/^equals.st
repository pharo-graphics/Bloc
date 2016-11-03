comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject widthSpec = widthSpec
		and: [ anotherObject heightSpec = heightSpec ]