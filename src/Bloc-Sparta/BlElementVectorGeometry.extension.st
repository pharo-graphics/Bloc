Extension { #name : #BlElementVectorGeometry }

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ pathCache pathOnSpartaCanvas: aCanvas
]
