examples - border
borderText
	<gtExample>
	| aText |
	
	aText := 'Text with border' asRopedText.
	aText attributes: {
		BrFontSizeAttribute size: 30.
		BrTextForegroundAttribute paint: Color gray.
		BrFontWeightAttribute thin }.

	^ BlTextElement new
		text: aText;
		constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ]