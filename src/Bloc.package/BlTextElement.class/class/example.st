example
example
	| space text textElement |
	
	text := SpText fromString: 'Hello world!', String cr, 'How are you?'.
	text attributes: {
		SpFontSizeAttribute size: 16.
		SpFontStyleAttribute italic } from: 1 to: text size. "the whole text"
	text attributes: {
		SpForegroundColorAttribute color: Color red.
		SpFontStyleAttribute normal  } from: 1 to: 12. "Hello world!"
	text attributes: {
		SpFontSizeAttribute size: 20.
		SpFontGenericFamilyAttribute monospace  } from: 13 to: text size. "How are you?"

	textElement := BlTextElement new.
	textElement text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		"c padding: (BlInsets all: 10)" ].
	textElement background: Color veryVeryLightGray.

	space := BlSpace new.
	space root addChild: textElement.
	BlElementSelection on: textElement.
	space show