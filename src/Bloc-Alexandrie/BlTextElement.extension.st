Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes and selection"
	paragraph aeDrawBeneathOn: aeCanvas

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
