Extension { #name : #BlEllipse }

{ #category : #'*Bloc-Sparta' }
BlEllipse >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape ellipse: self geometryBounds
]
