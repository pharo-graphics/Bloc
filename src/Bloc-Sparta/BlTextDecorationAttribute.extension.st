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
	| fromX toX aPathBuilder |
	
	fromX := aSpartaSpan baseline x + (self thickness / 2.0).
	toX := aSpartaSpan baseline x + aSpartaSpan advance - (self thickness / 2.0).
	
	aPathBuilder := aSpartaCanvas path.
	
	decoration typesDo: [ :eachType |
		eachType = BlTextDecorationType lineThrough
			ifTrue: [				
				aPathBuilder
					moveTo: (fromX @ ((aSpartaSpan baseline y / 2.0) - aSpartaSpan strikethroughOffset)) rounded;
					lineTo: (toX @ ((aSpartaSpan baseline y / 2.0) - aSpartaSpan strikethroughOffset)) rounded ].

		eachType = BlTextDecorationType underline
			ifTrue: [
				aPathBuilder
					moveTo: (fromX @ (aSpartaSpan baseline y + 2)) rounded;
					lineTo: (toX @ (aSpartaSpan baseline y + 2)) rounded ] ].
	
	
	^ aPathBuilder build
]
