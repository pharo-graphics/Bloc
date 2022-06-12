Extension { #name : #BlElementGeometry }

{ #category : #'*Bloc-Sparta' }
BlElementGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlElementGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ self subclassResponsibility
]
