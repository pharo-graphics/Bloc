Extension { #name : #BlTextOrientationAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextOrientationAttribute >> applyOnSpartaTextPainter: aTextPainter with: aSpartaSpan [
	aTextPainter perform: orientation
]
