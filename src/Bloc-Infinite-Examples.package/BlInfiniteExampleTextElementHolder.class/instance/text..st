accessing
text: aSpText
	| theWords aWordIterator aBreak |
	
	itemElement removeChildren.

	theWords := OrderedCollection new.
	aWordIterator := aSpText rope iterator.
	aBreak := true.
	[ aWordIterator hasNext ] whileTrue: [
		| aWord |
		aWord := aWordIterator nextWord.
		theWords	add: (BlTextElement new
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent.
				c flow newLine: aBreak ];
			text: (SpText fromRope: aWord);
			yourself).
		aBreak := false ].

	itemElement addChildren: theWords