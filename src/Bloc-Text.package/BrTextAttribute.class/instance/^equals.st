comparing
= anObject
	"Return true if I am equal to a given object"
	<return: #Boolean>
	
	self == anObject
		ifTrue: [ ^ true ].
	(anObject class = self class)
		ifFalse: [ ^ false ].
	
	^ self equals: anObject