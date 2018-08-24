Extension { #name : #BlGeometry }

{ #category : #'*Bloc-Sparta' }
BlGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlGeometry >> pathOnSpartaCanvas: aCanvas [
	<return: #TSpartaPath>

	^ pathCache pathOnSpartaCanvas: aCanvas
]
