Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawBeneathOnSpartaCanvas: aCanvas [

	paragraph drawHighlightsOnSpartaCanvas: aCanvas.
	paragraph drawSelectionOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.

	paragraph ifNil: [ ^ self ].
	self setupParagraphBeforeDrawing.
	self drawBeneathOnSpartaCanvas: aCanvas.
	aCanvas transform by: [ :t | t translateBy: self padding topLeft ] during: [ paragraph drawOn: aCanvas ]
]
