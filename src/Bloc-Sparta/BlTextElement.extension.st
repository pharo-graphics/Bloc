Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawBeneathOnSpartaCanvas: aCanvas [

	self drawHighlightsOnSpartaCanvas: aCanvas.
	self drawSelectionOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawHighlightsOnSpartaCanvas: aCanvas [

	highlightsMap ifNil: [ ^self ].
	self highlights do: [ :eachHighlight | 
		| rectangles |
		rectangles := self selectionRectanglesFrom: eachHighlight selection.
		self fillRectanglesBackground: rectangles onSpartaCanvas: aCanvas with: eachHighlight paint ]
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawOnSpartaCanvas: aCanvas [

	paragraph ifNil: [ ^ self ].
	self drawBeneathOnSpartaCanvas: aCanvas.

	super drawOnSpartaCanvas: aCanvas.

	aCanvas transform by: [ :t | t translateBy: self padding topLeft ] during: [ paragraph drawOnSpartaCanvas: aCanvas ]
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawSelection: aSelection onSpartaCanvas: aCanvas color: aColor [

	| rectangles |
	(aSelection isNil or: [ aSelection isEmpty ]) ifTrue: [ ^ self ].
	rectangles := self selectionRectanglesFrom: aSelection.
	rectangles do: [ :rect | 
		aCanvas fill
			paint: aColor;
			path: rect;
			draw ]
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawSelectionOnSpartaCanvas: aCanvas [ 

	self drawSelection: selection onSpartaCanvas: aCanvas  color: self class selectionColor 
]

{ #category : #'*Bloc-Sparta' }
BlTextElement >> fillRectanglesBackground: anArrayOfrectangles onSpartaCanvas: aCanvas with: aPaint [

	anArrayOfrectangles do: [ :rect | 
			aCanvas fill
				paint: aPaint;
				path: rect;
				draw ]
]
