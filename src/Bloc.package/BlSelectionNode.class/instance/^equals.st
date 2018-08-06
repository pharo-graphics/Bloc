comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	self hasRight = anObject hasRight
		ifFalse: [ ^ false ].

	(self hasRight and: [ self right ~= anObject right ])
		ifTrue: [ ^ false ].
		
	self hasLeft = anObject hasLeft
		ifFalse: [ ^ false ].
		
	(self hasLeft and: [ self left ~= anObject left ])
		ifTrue: [ ^ false ].
		
	self high = anObject high
		ifFalse: [ ^ false ].
		
	self selection = anObject selection
		ifFalse: [ ^ false ].

	^ true