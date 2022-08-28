Extension { #name : #BlTextParagraph }

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeDrawBeneathOn: aeCanvas [

	"Draw highlight attributes"
	self aeDrawHighlightsOn: aeCanvas.
	"Draw selection, if any"
	self aeDrawSelectionOn: aeCanvas.
]

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeDrawHighlightsOn: aeCanvas [

	highlights ifNil: [ ^ self ].

	highlights do: [ :eachHighlight | 
		| rectangles |
		rectangles := self selectionRectanglesFrom: eachHighlight selection.
		self aeFillRectanglesBackground: rectangles on: aeCanvas with: eachHighlight paint ]
]

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeDrawOn: aCanvas [	
	line aeDrawOn: aCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeDrawSelectionOn: aeCanvas [

	self aeDrawselection: selection on: aeCanvas color: self class selectionColor
]

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeDrawselection: aSelection on: aeCanvas color: aColor [

	| rectangles |
	(aSelection isNil or: [ aSelection isEmpty ]) ifTrue: [ ^ self ].
	rectangles := self selectionRectanglesFrom: aSelection.
	self aeFillRectanglesBackground: rectangles on: aeCanvas with: aColor
]

{ #category : #'*Bloc-Alexandrie' }
BlTextParagraph >> aeFillRectanglesBackground: anArrayOfrectangles on: aeCanvas with: aColor [

	"TODO: refactor the following is the only Alexandrie-specific code"

	aeCanvas restoreContextAfter: [ 
		aeCanvas setBackgroundWith: [ aeCanvas setSourceColor: aColor ].

		aeCanvas setBorderOff.

		aeCanvas drawClosedPathWith: [ :cairoContext |
			anArrayOfrectangles do: [ :each | cairoContext rectangle: each ] ].

		aeCanvas drawFigure ]
]
