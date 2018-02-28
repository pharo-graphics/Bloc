comparing
= anotherObject
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject start = self start
		and: [ anotherObject end = self end
			and: [ anotherObject text = self text ] ]