example
simpleText
	<gtExample>
	| text textElement |
	text := BrRopedText rope: (BrCollectionRope collection: (String loremIpsum: 50)).
	textElement := BlTextElement new.
	textElement text: text.
	textElement background: Color paleYellow.
	^ textElement
