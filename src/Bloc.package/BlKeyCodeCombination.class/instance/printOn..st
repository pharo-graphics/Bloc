printing
printOn: aStream
	aStream nextPut: $[.
	self modifiers isEmpty ifFalse: [ 
		aStream
			print: self modifiers;
			nextPut: $+ ].
	aStream
		nextPut: self charCode asCharacter asUppercase;
		nextPut: $]