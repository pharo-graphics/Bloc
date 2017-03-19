example
example
	| space text textElement |

	text := BrRopedText string: 'Hello world!', String cr, 'How are you?'.
	text attributes: {
		BrFontSizeAttribute size: 16.
		BrFontEmphasisAttribute italic } from: 1 to: text size. "the whole text"
	text attributes: {
		BrTextForegroundAttribute paint: Color red.
		BrFontEmphasisAttribute normal  } from: 1 to: 12. "Hello world!"
	text attributes: {
		BrFontSizeAttribute size: 20.
		BrFontGenericFamilyAttribute monospace  } from: 13 to: text size. "How are you?"

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