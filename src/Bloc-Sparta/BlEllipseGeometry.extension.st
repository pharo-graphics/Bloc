Extension { #name : #BlEllipseGeometry }

{ #category : #'*Bloc-Sparta' }
BlEllipseGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape ellipse: self geometryBounds
]

{ #category : #'*Bloc-Sparta' }
BlEllipseGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0
]

{ #category : #'*Bloc-Sparta' }
BlEllipseGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width
]
