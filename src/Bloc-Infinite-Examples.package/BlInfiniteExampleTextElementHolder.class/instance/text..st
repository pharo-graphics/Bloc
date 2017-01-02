accessing
text: aSpText
	| theWords aWordIterator aBreak |
	
	itemElement removeChildren.

	theWords := OrderedCollection new.
	aWordIterator := aSpText rope iterator.
	aBreak := true.
	[ aWordIterator hasNext ] whileTrue: [
		| aWord aText |
		aWord := aWordIterator nextWord.
		aText := SpText fromRope: aWord.
		aText attributes: { SpTextWrapAttribute none }.
		
		theWords	add: (BlTextElement new
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent.
				c flow newLine: aBreak ];
			text: aText;
			yourself).
		aBreak := false ].

	itemElement addChildren: theWords