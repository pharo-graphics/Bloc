initialization
defaultText
	| aText |
	aText := SpText fromString: (String loremIpsum: 1000000).
	aText attributes: { SpFontSizeAttribute size: 20 } from: 1 to: aText size.
	^ aText