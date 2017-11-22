comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	(anObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ anObject name = self name