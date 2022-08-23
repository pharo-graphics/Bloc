Extension { #name : #BlLineGeometry }

{ #category : #'*Bloc-Sparta' }
BlLineGeometry >> buildPathOnSpartaCanvas: aCanvas [
	^ aCanvas shape line: self from to: self to
]

{ #category : #'*Bloc-Sparta' }
BlLineGeometry >> containsPoint: aPoint in: anElement onSpartaCanvas: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"

	| aPath |
	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas stroke
		path: aPath;
		width: (anElement border width max: 6);
		containsPoint: aPoint
]
