example
exampleText
	| space text textElement |

	text := BrRopedText rope: (BlCollectionRope collection: (String loremIpsum: 30)).
	text attributes: { BrFontWeightAttribute bold }.

	textElement := self new.
	textElement editListener: BlTextEditListener new.
	textElement addEventHandler: BlSelectionHandler new.
	textElement relocate: 50@50.
	textElement text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent. ].
	textElement background: Color veryVeryLightGray.

	space := BlSpace new.
	space root addChild: textElement.
	space show.

	^ textElement