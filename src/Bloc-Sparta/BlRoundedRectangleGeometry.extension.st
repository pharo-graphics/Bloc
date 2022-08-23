Extension { #name : #BlRoundedRectangleGeometry }

{ #category : #'*Bloc-Sparta' }
BlRoundedRectangleGeometry >> buildPathOnSpartaCanvas: aCanvas [
	<return: #TSpartaPath>

	^ cornerRadii max isZero
		"Rectangle is polymorphic with SpartaPath"
		ifTrue: [ self geometryBounds ]
		ifFalse: [ aCanvas shape roundedRectangle: self geometryBounds radii: cornerRadii asArray ]
]

{ #category : #'*Bloc-Sparta' }
BlRoundedRectangleGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0
]

{ #category : #'*Bloc-Sparta' }
BlRoundedRectangleGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width
]
