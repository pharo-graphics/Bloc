Extension { #name : #BlTextBackgroundAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextBackgroundAttribute >> drawBelowOnSpartaCanvas: aCanvas with: aSpan [
	"I render background under text span"

	aCanvas fill
		paint: paint;
		path: (aSpan bounds translateBy: aSpan baseline);
		draw
]
