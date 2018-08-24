Extension { #name : #BlBounds }

{ #category : #'*Bloc-Sparta' }
BlBounds >> asSpartaPathOn: aSpartaCanvas [
	"I am polymorphic with TSpartaPath and can be used directly"

	^ self
]

{ #category : #'*Bloc-Sparta' }
BlBounds >> spartaClipOn: aSpartaCanvas with: aSpartaClipper [
	"I am polymorphic with TSpartaPath and can be used directly"

	aSpartaClipper pushRectangle: self
]

{ #category : #'*Bloc-Sparta' }
BlBounds >> spartaFillOn: aSpartaCanvas with: aSpartaFiller [
	"I am polymorphic with TSpartaPath and can be used directly"

	aSpartaFiller fillRectangle: self
]

{ #category : #'*Bloc-Sparta' }
BlBounds >> spartaStrokeOn: aSpartaCanvas with: aSpartaStrokePainter [
	"I am polymorphic with TSpartaPath and can be used directly"

	aSpartaStrokePainter strokeRectangle: self
]
