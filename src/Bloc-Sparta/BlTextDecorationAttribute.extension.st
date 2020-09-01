Extension { #name : #BlTextDecorationAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextDecorationAttribute >> applyOnSpartaTextPainter: aTextPainter [
	aTextPainter decoration: self decoration
]

{ #category : #'*Bloc-Sparta' }
BlTextDecorationAttribute >> drawAboveOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	"I render an underline above the text span"

	aSpartaCanvas stroke
		paint: self color;
		path: (self lineOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan);
		width: self thickness;
		draw
]

{ #category : #'*Bloc-Sparta' }
BlTextDecorationAttribute >> lineOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	| aFromPoint aToPoint |
	
	aFromPoint := ((aSpartaSpan baseline x + (self thickness / 2.0)) @ (aSpartaSpan baseline y + 2)) rounded.
	aToPoint := ((aSpartaSpan baseline x + aSpartaSpan advance - (self thickness / 2.0)) @ (aSpartaSpan baseline y + 2)) rounded.
	
	^ aSpartaCanvas shape 
		line: aFromPoint
		to: aToPoint
]
