Class {
	#name : #BlRectangleGeometry,
	#superclass : #BlElementGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #comparing }
BlRectangleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlRectangleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Note: we have to pass BlElement in order to give geometry a chance to use element properties
	as as border during the testing process"
	
	(aPoint x < 0 and: [ aPoint y < 0 ])
		ifTrue: [ ^ false ].

	^ aPoint x < aBlElement width
		and: [ aPoint y < aBlElement height ]
]

{ #category : #'api - bounds' }
BlRectangleGeometry >> geometryBounds: aBlBounds of: aBlElement [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	
	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #testing }
BlRectangleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlRectangleGeometry >> hasJoins [

	^ true
]

{ #category : #geometry }
BlRectangleGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"
]

{ #category : #geometry }
BlRectangleGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngleInRadians [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRect dx dy scale x y halfWidth halfHeight usedCenter insets bnds |
	insets := anElement margin.
	bnds := anElement measuredBounds asRectangle.

	adjustedRect := Rectangle
		                origin: bnds topLeft + insets topLeft negated
		                corner: bnds bottomRight + insets bottomRight.

	usedCenter := adjustedRect center.
	dx := anAngleInRadians cos.
	dy := anAngleInRadians sin.

	halfWidth := adjustedRect width / 2.
	halfHeight := adjustedRect height / 2.

	scale := 1 / (dx abs / halfWidth max: dy abs / halfHeight).

	x := usedCenter x + (dx * scale).
	y := usedCenter y + (dy * scale).

	^ x @ y
]

{ #category : #'api - cache' }
BlRectangleGeometry >> releaseStrokedBoundsCache [
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's outskirts."

	^ anElement outskirts strokedBounds: aBlBounds of: anElement
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsCentered: aBlBounds of: aBlElement [

	| aHalfWidth |
	aHalfWidth := aBlElement border width / 2.0.

	^ aBlBounds
		left: aHalfWidth negated
		top: aHalfWidth negated
		right: aBlElement width + aHalfWidth
		bottom: aBlElement height + aHalfWidth
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsInside: aBlBounds of: aBlElement [
	"Stroked inside bounds property is equal to geometry bounds"

	^ aBlBounds
		left: 0
		top: 0
		right: aBlElement width
		bottom: aBlElement height
]

{ #category : #'visual bounds' }
BlRectangleGeometry >> strokedBoundsOutside: aBlBounds of: aBlElement [

	| aBorderWidth |
	aBorderWidth := aBlElement border width.

	^ aBlBounds
		left: aBorderWidth negated
		top: aBorderWidth negated
		right: aBlElement width + aBorderWidth
		bottom: aBlElement height + aBorderWidth
]
