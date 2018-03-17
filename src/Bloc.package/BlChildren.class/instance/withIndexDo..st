children - enumerating
withIndexDo: elementAndIndexBlock 
	"Just like with:do: except that the iteration index supplies the second argument to the block."
	| anIndex |
	
	anIndex := 0.
	self do: [ :anElement |
		anIndex := anIndex + 1.
		elementAndIndexBlock
			value: anElement
			value: anIndex ]