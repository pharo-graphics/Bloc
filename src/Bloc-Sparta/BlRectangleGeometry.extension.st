Extension { #name : #BlRectangleGeometry }

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> pathOnSpartaCanvas: aCanvas of: aBlElement [
	<return: #TSpartaPath>
	
	^ aBlElement boundsInLocal
]

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> strokedBounds: aBlBounds of: anElement on: aCanvas [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	<return: #BlBounds>
	
	^ anElement outskirts strokedBounds: aBlBounds of: anElement on: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [
	<return: #BlBounds>
	| aHalfWidth |

	aHalfWidth := aBlElement border width / 2.0.

	^ aBlBounds
		left: aHalfWidth negated
		top: aHalfWidth negated
		right: aBlElement width + aHalfWidth
		bottom: aBlElement height + aHalfWidth
]

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> strokedBoundsInside: aBlBounds of: aBlElement on: aCanvas [
	"Stroked inside bounds property is equal to geometry bounds"
	<return: #BlBounds>

	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #'*Bloc-Sparta' }
BlRectangleGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [
	<return: #BlBounds>
	| aBorderWidth |

	aBorderWidth := aBlElement border width.

	^ aBlBounds
		left: aBorderWidth negated
		top: aBorderWidth negated
		right: aBlElement width + aBorderWidth
		bottom: aBlElement height + aBorderWidth
]
