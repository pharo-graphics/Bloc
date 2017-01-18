example
exampleText
	| space text textElement |

	text := SpText fromString: (String loremIpsum: 300).
	text attributes: {
		SpFontSizeAttribute size: 20.
		SpFontGenericFamilyAttribute monospace  }.

	textElement := BlTextElement new.
	textElement text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent. ].
	textElement background: Color veryVeryLightGray.

	space := BlSpace new.
	space root addChild: textElement.
	BlElementSelection on: textElement.
	space show