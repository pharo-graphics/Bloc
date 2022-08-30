Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes"
	self aeDrawHighlightsOn: aeCanvas.
	"Draw selection, if any"
	self aeDrawSelectionOn: aeCanvas.
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawHighlightsOn: aeCanvas [
	highlightsMap ifNil: [ ^self ].
	self highlights do: [ :eachHighlight |  
		| rectangles |
		rectangles := self selectionRectanglesFrom: eachHighlight selection.
		self aeFillRectanglesBackground: rectangles on: aeCanvas with: eachHighlight paint ]
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawOnlyMeOn: aeCanvas [

	paragraph ifNil: [ ^ self ].
	self aeDrawBeneathOn: aeCanvas.
	super aeDrawOnlyMeOn: aeCanvas.
	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: self padding topLeft.
		"Draw text with attributes"
		paragraph aeDrawOn: aeCanvas ]
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawSelectionOn: aeCanvas [

	self aeDrawselection: selection on: aeCanvas color: self class selectionColor
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeDrawselection: aSelection on: aeCanvas color: aColor [

	| rectangles |
	(aSelection isNil or: [ aSelection isEmpty ]) ifTrue: [ ^ self ].
	rectangles := self selectionRectanglesFrom: aSelection.
	self aeFillRectanglesBackground: rectangles on: aeCanvas with: aColor
]

{ #category : #'*Bloc-Alexandrie' }
BlTextElement >> aeFillRectanglesBackground: anArrayOfrectangles on: aeCanvas with: aColor [

	"TODO: refactor the following is the only Alexandrie-specific code"

	aeCanvas restoreContextAfter: [ 
		aeCanvas setBackgroundWith: [ aeCanvas setSourceColor: aColor ].

		aeCanvas setBorderOff.

		aeCanvas drawClosedPathWith: [ :cairoContext |
			anArrayOfrectangles do: [ :each | cairoContext rectangle: each ] ].

		aeCanvas drawFigure ]
]
