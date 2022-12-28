Extension { #name : #BlEllipseGeometry }

{ #category : #'*Bloc-Sparta' }
BlEllipseGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape ellipse: self geometryBounds
]
