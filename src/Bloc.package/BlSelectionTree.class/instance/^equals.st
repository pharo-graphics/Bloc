comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	self hasRoot = anObject hasRoot
		ifFalse: [ ^ false ].
		
	^ self hasRoot
		ifTrue: [ self root = anObject root ]
		ifFalse: [ false ]