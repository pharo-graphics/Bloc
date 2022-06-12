Extension { #name : #BlOutskirts }

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [
	self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement [
	self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlOutskirts >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	^ self subclassResponsibility
]
