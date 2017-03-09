example
exampleText
	| space text textElement |

	text := BrRopedText rope: (BrCollectionRope collection: (String loremIpsum: 30)).

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