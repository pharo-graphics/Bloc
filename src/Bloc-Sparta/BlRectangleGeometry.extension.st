Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ aBlElement boundsInLocal
]
