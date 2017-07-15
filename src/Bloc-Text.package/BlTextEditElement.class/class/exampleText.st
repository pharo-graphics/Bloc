example
exampleText
	| space text textElement |

	text := BrRopedText rope: (BrCollectionRope collection: (String loremIpsum: 30)).
	text attributes: { BrFontWeightAttribute bold }.

	textElement := self new.
	textElement position: 50@50.
	textElement text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent. ].
	textElement background: Color veryVeryLightGray.

	space := BlSpace new.
	space root addChild: textElement.
	space show