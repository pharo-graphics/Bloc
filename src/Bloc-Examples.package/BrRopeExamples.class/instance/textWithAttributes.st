as yet unclassified
textWithAttributes
	<gtExample>
	| text |
	text := 'The moldable editor ' asRopedText.
	text insertString: 'can be adapted ' at: text size.
	text insertString: 'to the context' at: text size.
	text 
		attributes: { BrFontWeightAttribute bold } 
		from: 5
		to: 12.
	text 
		attributes: {BrFontItalicAttribute new } 
		from: 42
		to: 49.
	^ text