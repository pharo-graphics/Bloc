Extension { #name : #BlTextFontAndStyleBuilder }

{ #category : #'*Bloc-Sparta' }
BlTextFontAndStyleBuilder >> applyOnSpartaTextPainter: aTextPainter [
	self hasCustomColor
		ifTrue: [ aTextPainter paint: self color ].
	self hasCustomDecoration
		ifTrue: [ aTextPainter decoration: self decoration ]
]
