Extension { #name : #BlElementVectorGeometry }

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> containsPoint: aPoint in: anElement onSpartaCanvas: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"

	| aPath |
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas fill
		path: aPath;
		containsPoint: aPoint
]

{ #category : #'*Bloc-Sparta' }
BlElementVectorGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ pathCache pathOnSpartaCanvas: aCanvas
]
