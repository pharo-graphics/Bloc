Extension { #name : #BlBorder }

{ #category : #'*Bloc-Sparta' }
BlBorder >> drawOnSpartaCanvas: aSpartaCanvas of: anElement [
	anElement outskirts drawBorder: self onSpartaCanvas: aSpartaCanvas of: anElement
]
