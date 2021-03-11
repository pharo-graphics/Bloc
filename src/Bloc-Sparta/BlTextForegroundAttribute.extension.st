Extension { #name : #BlTextForegroundAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnFontAndStyleBuilder: aBlTextStyleBuilder [
	aBlTextStyleBuilder color: self paint
]

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnSpartaTextPainter: aTextPainter [
	aTextPainter paint: paint
]
