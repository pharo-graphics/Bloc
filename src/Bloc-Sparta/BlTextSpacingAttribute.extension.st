Extension { #name : #BlTextSpacingAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextSpacingAttribute >> applyOnSpartaTextPainter: aTextPainter with: aSpartaSpan [
	aTextPainter spacing: self spacing
]
