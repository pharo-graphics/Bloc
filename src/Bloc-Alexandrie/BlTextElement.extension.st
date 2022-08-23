Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes"
	paragraph aeDrawHighlightsOn: aeCanvas.
	"Draw selection, if any"
	paragraph aeDrawSelectionOn: aeCanvas.
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawOnlyMeOn: aeCanvas [

	paragraph ifNil: [^self].
	self setupParagraphBeforeDrawing.
	self aeDrawBeneathOn: aeCanvas.

	super aeDrawOnlyMeOn: aeCanvas.

	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: self padding topLeft.
		"Draw text with attributes"
		paragraph aeDrawOn: aeCanvas ]
]
