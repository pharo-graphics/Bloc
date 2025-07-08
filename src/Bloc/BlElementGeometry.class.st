Class {
	#name : #BlElementGeometry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #converting }
BlElementGeometry >> asElement [
	"Answer an element with me as its geometry, with appropriate default values."

	| anElement |
	anElement := BlElement new
		geometry: self;
		border: (BlBorder paint: Color gray width: 2);
		yourself.

	self hasCaps
		ifTrue: [
			anElement
				background: Color transparent;
				outskirts: BlOutskirts centered ]
		ifFalse: [
			anElement
				background: (Color gray alpha: 0.4) ].

	^ anElement
]

{ #category : #'geometry testing' }
BlElementGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."
	
	^ self subclassResponsibility
]

{ #category : #'api - bounds' }
BlElementGeometry >> geometryBounds: aBounds of: aBlElement [
	"Load my geometry bounds for a given element in a mutable rectangle.
	@see #geometryBounds for more info"
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlElementGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ self subclassResponsibility
]

{ #category : #testing }
BlElementGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ self subclassResponsibility
]

{ #category : #geometry }
BlElementGeometry >> matchElement: anElement [
	"Adapt me to match the size of a given element"

	self subclassResponsibility
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterForAnchor: anAnchor [
	" returns  the position (Point) on myself border at angle anAngle (en radians)"

	^ self
		  pointOnPerimeterOfElement: anAnchor element
		  atRadians: anAnchor radians - 90 degreesToRadians
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atDegrees: aDegrees [
	" returns  the position (Point) on myself border at angle aDegrees "

	^ self
		  pointOnPerimeterOfElement: anElement
		  atRadians: aDegrees degreesToRadians
]

{ #category : #geometry }
BlElementGeometry >> pointOnPerimeterOfElement: anElement atRadians: anAngle [
	" default version that should be redefined according to my perimeter computation "

	^ 0 @ 0
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseCache [
]

{ #category : #'api - cache' }
BlElementGeometry >> releaseStrokedBoundsCache [
	self subclassResponsibility
]

{ #category : #serialization }
BlElementGeometry >> storeOn: aStream [
	aStream nextPutAll: self class name; space; nextPutAll: 'new'
]

{ #category : #'visual bounds' }
BlElementGeometry >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's border configuration.
	Dispatch through outskirts first"
	
	^ self subclassResponsibility
]
