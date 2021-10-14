Extension { #name : #BlTextForegroundAttribute }

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnFontAndStyleBuilder: aBlTextFontAndStyleBuilder [

	aBlTextFontAndStyleBuilder color: self paint
]

{ #category : #'*Bloc-Sparta' }
BlTextForegroundAttribute >> applyOnSpartaTextPainter: aTextPainter [
	aTextPainter paint: paint
]
