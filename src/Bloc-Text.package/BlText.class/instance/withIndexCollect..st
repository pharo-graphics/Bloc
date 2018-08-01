text - enumeration
withIndexCollect: elementAndIndexBlock 
	"Just like with:collect: except that the iteration index supplies the second argument to the block."

	^ Array streamContents: [ :aStream |
		| anIndex |
		anIndex := 1.
		self do: [ :aCharacter |
			aStream nextPut: (elementAndIndexBlock value: aCharacter value: anIndex).
			anIndex := anIndex + 1 ] ]