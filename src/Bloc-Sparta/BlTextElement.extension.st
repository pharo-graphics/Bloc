Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	paragraph
		ifNil: [ ^ self ].

	aCanvas transform
		by: [ :t | t translateBy: self padding topLeft ]
		during: [
			paragraph selection: self selection.
			paragraph containerExtent: self extent.

			paragraph drawOn: aCanvas ].

	paragraph drawSelectionOnSpartaCanvas: aCanvas
]
