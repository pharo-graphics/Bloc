Extension { #name : #BlPolylineGeometry }

{ #category : #'*Bloc-Sparta' }
BlPolylineGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| aCollection pathBuilder |
	
	aCollection := self vertices.
	
	pathBuilder := aCanvas path
		absolute;
		moveTo: aCollection first.
	aCollection do: [ :pt | pathBuilder lineTo: pt ].
	
	^ pathBuilder finish
]

{ #category : #'*Bloc-Sparta' }
BlPolylineGeometry >> containsPoint: aPoint in: anElement onSpartaCanvas: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"

	| aPath |
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas stroke
		path: aPath;
		width: anElement border width;
		containsPoint: aPoint
]
