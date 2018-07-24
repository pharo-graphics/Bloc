text - attributes style
stylerDo: aBlock
	"I allow users to apply attributes in a bulk fashion with the help of text attributes styler.

	Example:
	[[[
		| text |
		text := 'Hi John' asRopedText.
		text stylerDo: [ :aStyler | aStyler bold italic foreground: Color red ].
	]]]"
	| aStyler |
	
	aStyler := self styler.
	aBlock value: aStyler.
	aStyler style