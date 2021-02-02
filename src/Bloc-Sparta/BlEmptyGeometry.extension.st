Extension { #name : #BlEmptyGeometry }

{ #category : #'*Bloc-Sparta' }
BlEmptyGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ SpartaNullPath new
]
