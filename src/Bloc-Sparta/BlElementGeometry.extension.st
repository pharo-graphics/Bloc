Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Sparta' }
BlElementGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ self subclassResponsibility
]
