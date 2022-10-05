Extension { #name : #BlTextElement }

{ #category : #'*Bloc-Sparta' }
BlTextElement >> drawBeneathOnSpartaCanvas: aCanvas [

	"self drawHighlightsOnSpartaCanvas: aCanvas"
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
	

	super drawOnSpartaCanvas: aCanvas.
	self drawBeneathOnSpartaCanvas: aCanvas.

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

{ #category : #'*Bloc-Sparta' }
BlTextElement >> fullDrawOnSpartaCanvas: aCanvas [

	flags clearNeedsPaint.

	"We do not draw transparent elements at all"
	self isTransparent ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible ifFalse: [ ^ self ].

	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ] during: [ 
			aCanvas transform
				by: self transformation matrix
				translated: self position x @ 0
				during: [ :aTransformedCanvas | 
					self errorHandler
						with: self
						do: [ 
							self drawHighlightsOnSpartaCanvas: aCanvas.
							self drawSelectionOnSpartaCanvas: aCanvas.
							aCanvas transform
								by: [ :aTransform | 
									aTransform translateBy: 0 @ self position y ]
								during: [ self drawMeWithEffectsOnCanvas: aCanvas ] ]
						failed: [ :anError | 
							self drawError: anError onSpartaCanvas: aCanvas ] ] ]
]
