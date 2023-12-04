Extension { #name : 'BlTextElement' }

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes"
	self aeDrawHighlightsOn: aeCanvas
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawGeometryOn: aeCanvas [

	paragraph ifNil: [ ^ self ].
	super aeDrawGeometryOn: aeCanvas.
	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: self padding topLeft.
		"Draw text with attributes"
		paragraph aeDrawOn: aeCanvas ]
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawHighlightsOn: aeCanvas [
	highlightsMap ifNil: [ ^self ].
	self highlights do: [ :eachHighlight |  
		| rectangles |
		rectangles := self selectionRectanglesFrom: eachHighlight selection.
		self aeDrawRectangles: rectangles on: aeCanvas with: eachHighlight paint ]
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawOn: aeCanvas [

	aeCanvas restoreContextAfter: [  
		aeCanvas pathTranslate: self position x @ 0.
		"self aeDrawSelectionOn: aeCanvas."
		self aeDrawBeneathOn: aeCanvas].
	super aeDrawOn: aeCanvas
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawRectangles: anArrayOfrectangles on: aeCanvas with: aColor [

	"TODO: refactor the following is the only Alexandrie-specific code"

	aeCanvas restoreContextAfter: [ 

		aeCanvas pathFactory: [ :cairoContext |
			anArrayOfrectangles do: [ :each | cairoContext rectangle: each ] ].

		aeCanvas setBackgroundWith: [
			aeCanvas setSourceColor: aColor twiceLighter twiceLighter ].

		aeCanvas setOutskirtsOutside.
		aeCanvas setBorderBlock: [ 
			aeCanvas setSourceColor: aColor twiceDarker.
			aeCanvas setJoinRound.
			aeCanvas setBorderWidth: 1 ].

		aeCanvas drawFigure ]
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawSelectionOn: aeCanvas [

	"self aeDrawselection: selection on: aeCanvas color: self class selectionColor"
]

{ #category : '*Bloc-Alexandrie' }
BlTextElement >> aeDrawselection: aSelection on: aeCanvas color: aColor [

	| rectangles |
	(aSelection isNil or: [ aSelection isEmpty ]) ifTrue: [ ^ self ].
	rectangles := self selectionRectanglesFrom: aSelection.
	self aeDrawRectangles: rectangles on: aeCanvas with: aColor
]
