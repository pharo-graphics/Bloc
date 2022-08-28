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
BlTextParagraph >> drawHighlightsOnSpartaCanvas: aCanvas [

	highlights ifNil: [ ^ self ].

	highlights do: [ :eachHighlight | 
		| rectangles |
		rectangles := self selectionRectanglesFrom: eachHighlight selection.
		self fillRectanglesBackground: rectangles onSpartaCanvas: aCanvas with: eachHighlight paint ]
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawOnSpartaCanvas: aCanvas [	
	line drawOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawSelection: aSelection onSpartaCanvas: aCanvas color: aColor [

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
BlTextParagraph >> drawSelectionOnSpartaCanvas: aCanvas [ 

	self drawSelection: selection onSpartaCanvas: aCanvas  color: self class selectionColor 
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> fillRectanglesBackground: anArrayOfrectangles onSpartaCanvas: aCanvas with: aPaint [

	anArrayOfrectangles do: [ :rect | 
			aCanvas fill
				paint: aPaint;
				path: rect;
				draw ]
]
