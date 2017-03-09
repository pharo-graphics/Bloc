rope - printing
printOn: aStream
	
	self do: [ :anItem | anItem isCharacter
		ifTrue: [ aStream nextPut: anItem ]
		ifFalse: [ aStream nextPutAll: anItem asString ] ]