Extension { #name : #BlTextParagraph }

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> createSpartaTextPainter: aBlSpan on: aSpartaCanvas [
	"I create and return a sparta text painter for given span (BrRope) and sparta canvas.
	Additionally I also initialize a corresponding font group according to span's attributes.
	Note: I assume that a given rope is homogeneous of type character; every item has the same attributes and type"

	| aFontBuilder aTextPainter theAttributes |
	theAttributes := aBlSpan attributes.
	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.

	theAttributes do: [ :anAttribute | 
			anAttribute applyOnSpartaFontBuilder: aFontBuilder.
			anAttribute applyOnSpartaTextPainter: aTextPainter ].

	aTextPainter font: aFontBuilder build.

	aTextPainter string: (String streamContents: [ :aStream |
		aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).

	^ aTextPainter
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawHighlightsOnSpartaCanvas: aCanvas padding: aBlInsets [
	
	(self highlights isNil or: [ self highlights isEmpty ])
		ifTrue: [ ^ self ].

	self highlights do: [ :eachHighlight |
		eachHighlight selection do: [ :aSelection |
			| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition aSelectionBounds |

			aStart := aSelection from min: self text size.
			anEnd := aSelection to min: self text size.

			aSelectionStartSpan := self spanAtIndex: aStart.
			aSelectionEndSpan := self spanAtIndex: anEnd.

			aSelectionStartPosition := aStart isZero
				ifTrue: [ 0@0 ]
				ifFalse: [ (aSelectionStartSpan positionAt: aStart) + (aBlInsets left @ 0) ].
			aSelectionEndPosition := anEnd = self text size
				ifTrue: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets width @ 0) ]
				ifFalse: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets left @ 0) ].

			aSelectionBounds := (aSelection to > self text size)
				"containerExtent includes padding"
				ifTrue: [ (aSelectionStartPosition x @ 0) corner: self containerExtent ]
				ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ self containerExtent y) ].

			aCanvas fill
				paint: eachHighlight paint;
				path: aSelectionBounds;
				draw ] ]
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawOnSpartaCanvas: aCanvas [	
	self line drawOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawSelectionOnSpartaCanvas: aCanvas padding: aBlInsets [
	
	(self selection isNil or: [ self selection isEmpty ])
		ifTrue: [ ^ self ].

	self selection do: [ :aSelection |
		| aStart anEnd aSelectionStartSpan aSelectionEndSpan aSelectionStartPosition aSelectionEndPosition aSelectionBounds |

		aStart := aSelection from min: self text size.
		anEnd := aSelection to min: self text size.

		aSelectionStartSpan := self spanAtIndex: aStart.
		aSelectionEndSpan := self spanAtIndex: anEnd.

		aSelectionStartPosition := aStart isZero
			ifTrue: [ 0@0 ]
			ifFalse: [ (aSelectionStartSpan positionAt: aStart) + (aBlInsets left @ 0) ].
		aSelectionEndPosition := anEnd = self text size
			ifTrue: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets width @ 0) ]
			ifFalse: [ (aSelectionEndSpan positionAt: anEnd) + (aBlInsets left @ 0) ].

		aSelectionBounds := (aSelection to > self text size)
			"containerExtent includes padding"
			ifTrue: [ (aSelectionStartPosition x @ 0) corner: self containerExtent ]
			ifFalse: [ (aSelectionStartPosition x @ 0) corner: (aSelectionEndPosition x @ self containerExtent y) ].

		aCanvas fill
			paint: ((Color r: 105 g: 171 b: 253 range: 255) alpha: 0.35);
			path: aSelectionBounds;
			draw ]
]
