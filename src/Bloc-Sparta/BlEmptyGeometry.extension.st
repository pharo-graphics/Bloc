Extension { #name : #BlEmptyGeometry }

{ #category : #'*Bloc-Sparta' }
BlEmptyGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ SpartaNullPath new
]

{ #category : #'*Bloc-Sparta' }
BlEmptyGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ aBlBounds
		left: 0
		top: 0
		right: anElement width
		bottom: anElement height
]
