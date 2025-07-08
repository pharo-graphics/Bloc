Class {
	#name : #BlCircleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'radius',
		'origin'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #comparing }
BlCircleGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlCircleGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	| centerX centerY |
	centerX := origin x + radius.
	centerY := origin y + radius.
	^ ((aPoint x - centerX) squared + (aPoint y - centerY) squared) < radius squared
]

{ #category : #'geometry bounds' }
BlCircleGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: self origin
		extent: (self radius * 2.0) asPoint
]

{ #category : #testing }
BlCircleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlCircleGeometry >> hasJoins [

	^ false
]

{ #category : #comparing }
BlCircleGeometry >> hash [
	^ self class hash
]

{ #category : #initialization }
BlCircleGeometry >> initialize [
	super initialize.
	
	radius := 0.
	origin := 0@0
]

{ #category : #geometry }
BlCircleGeometry >> matchExtent: anExtent [
	radius := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlCircleGeometry >> origin [
	^ origin
]

{ #category : #geometry }
BlCircleGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	| adjustedRectangle prevRadius prevOrigin pt |
	prevRadius := radius.
	prevOrigin := origin.
	adjustedRectangle := anElement margin expand:
		                     anElement measuredBounds.
	self matchExtent: adjustedRectangle extent.
	pt := radius * anAngle cos @ (radius * anAngle sin).
	radius := prevRadius.
	origin := prevOrigin.
	^ pt + adjustedRectangle center
]

{ #category : #accessing }
BlCircleGeometry >> radius [
	^ radius
]
