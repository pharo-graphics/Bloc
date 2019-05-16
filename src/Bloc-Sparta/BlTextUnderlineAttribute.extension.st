Extension { #name : #BlTextUnderlineAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextUnderlineAttribute >> drawAboveOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	"I render an underline above the text span"
	
	self isAbove
		ifFalse: [ ^ self ].
		
	self drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
]

{ #category : #'*Bloc-Sparta' }
BlTextUnderlineAttribute >> drawBelowOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	"I render an underline under the text span"
	
	self isBelow
		ifFalse: [ ^ self ].

	self drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan
]

{ #category : #'*Bloc-Sparta' }
BlTextUnderlineAttribute >> drawOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	"I render an underline"
	
	aSpartaCanvas stroke
		alpha: self opacity;
		paint: self paint;
		path: (aSpartaCanvas shape 
			line: (aSpartaSpan baseline + (2negated@2)) rounded 
			to: (((aSpartaSpan width + aSpartaSpan baseline x) 
						@ aSpartaSpan baseline y) + (2@2) ) rounded);
		width: self width;
		in: [ :aPainter | self style applyOn: aPainter ];
		draw
]
