printing
printOn: aStream

	self hasLeft ifTrue: [ self left printOn: aStream ].
	self selection printOn: aStream.
	self hasRight ifTrue: [ self right printOn: aStream ].