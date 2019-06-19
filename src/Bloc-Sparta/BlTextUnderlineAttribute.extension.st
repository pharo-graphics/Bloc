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
		path: (self lineOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan);
		width: self width;
		in: [ :aPainter | self style applyOn: aPainter ];
		draw
]

{ #category : #'*Bloc-Sparta' }
BlTextUnderlineAttribute >> lineOnSpartaCanvas: aSpartaCanvas with: aSpartaSpan [
	| aFromPoint aToPoint |
	
	aFromPoint := (("aSpartaSpan left negated + "aSpartaSpan baseline x) @ (aSpartaSpan baseline y + 2)) rounded.
	aToPoint := (("aSpartaSpan left negated + "aSpartaSpan baseline x + aSpartaSpan advance) @ (aSpartaSpan baseline y + 2)) rounded.
	
	^ aSpartaCanvas shape 
		line: aFromPoint
		to: aToPoint
]
