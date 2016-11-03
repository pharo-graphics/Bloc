printing
printOn: aStream
	aStream
		nextPut: $[;
		print: self modifiers;
		nextPut: self charCode asCharacter;
		nextPut: $]