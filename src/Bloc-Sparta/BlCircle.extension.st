Extension { #name : #BlCircle }

{ #category : #'*Bloc-Sparta' }
BlCircle >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape ellipse: self geometryBounds
]
