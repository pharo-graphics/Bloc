Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawOnSpartaCanvas: aCanvas [
	| aParagraphBounds aWidgetBounds |
	super drawOnSpartaCanvas: aCanvas.

	paragraph
		ifNil: [ ^ self ].

	aCanvas transform
		by: [ :t | t translateBy: self padding topLeft ]
		during: [
			paragraph selection: self selection.
			paragraph containerExtent: self extent.

			paragraph drawOn: aCanvas ]

	"aParagraphBounds := BlBounds fromRectangle: (paragraph bounds translateBy: paragraph baseline).
	aWidgetBounds := BlBounds fromRectangle: self bounds inLocal asRectangle.

	aCanvas transform
		by: [ :t | t translateBy: aWidgetBounds center - aParagraphBounds center ]
		during: [
			paragraph selection: self selection.
			paragraph containerExtent: self extent.

			paragraph drawOn: aCanvas ]"
]
