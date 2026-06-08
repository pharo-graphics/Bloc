"
I represent a historgram-like geometry.

I have an orientation and a collection of values between 0.0 and 1.0.
"
Class {
	#name : #BlHistogramGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'values',
		'orientation'
	],
	#classVars : [
		'Horizontal',
		'HorizontalInverted',
		'Vertical',
		'VerticalInverted'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'class initialization' }
BlHistogramGeometry class >> initialize [

	Vertical := #Vertical.
	VerticalInverted := #VerticalInverted.
	Horizontal := #Horizontal.
	HorizontalInverted := #HorizontalInverted
]

{ #category : #accessing }
BlHistogramGeometry class >> values: aCollection [

	^ self new
		values: aCollection;
		yourself
]

{ #category : #accessing }
BlHistogramGeometry >> beHorizontal [

	orientation := Horizontal.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beHorizontalInverted [

	orientation := HorizontalInverted.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beVertical [

	orientation := Vertical.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beVerticalInverted [

	orientation := VerticalInverted.
	self releaseCache
]

{ #category : #'geometry testing' }
BlHistogramGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."
	
	^ BlPolygonHitTester doPolygonBy: self vertices include: aPoint
]

{ #category : #private }
BlHistogramGeometry >> delta [

	(self isVertical or: [ self isVerticalInverted ]) ifTrue: [
		^ 0 @ (self extent y / self values size) asFloat ].
	
	^ (self extent x / self values size) asFloat @ 0
]

{ #category : #private }
BlHistogramGeometry >> direction [

	self isVertical ifTrue: [ ^ 1.0 @ 0.0 ].
	self isVerticalInverted ifTrue: [ ^ -1.0 @ 0.0 ].
	self isHorizontalInverted ifTrue: [ ^ 0.0 @ 1.0 ].
	^ 0.0 @ -1.0
]

{ #category : #testing }
BlHistogramGeometry >> hasCaps [
	"Answer whether my path has caps, i.e. if I include an open line."

	^ false
]

{ #category : #testing }
BlHistogramGeometry >> hasJoins [
	"Answer whether I have joins, i.e. my path presents edges between a segment and another."

	^ true
]

{ #category : #initialization }
BlHistogramGeometry >> initialize [

	super initialize.
	
	values := #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	orientation := Horizontal
]

{ #category : #testing }
BlHistogramGeometry >> isHorizontal [

	^ orientation = Horizontal
]

{ #category : #testing }
BlHistogramGeometry >> isHorizontalInverted [

	^ orientation = HorizontalInverted
]

{ #category : #testing }
BlHistogramGeometry >> isVertical [

	^ orientation = Vertical
]

{ #category : #testing }
BlHistogramGeometry >> isVerticalInverted [

	^ orientation = VerticalInverted
]

{ #category : #geometry }
BlHistogramGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #private }
BlHistogramGeometry >> origin [

	self isVertical ifTrue: [ ^ 0.0 @ 0.0 ].
	self isVerticalInverted ifTrue: [ ^ self extent x asFloat @ 0.0 ].
	self isHorizontalInverted ifTrue: [ ^ 0.0 @ 0.0 ].
	^ 0.0 @ self extent y asFloat
]

{ #category : #accessing }
BlHistogramGeometry >> values [

	^ values
]

{ #category : #accessing }
BlHistogramGeometry >> values: aCollectionOfFloats [

	values := aCollectionOfFloats.
	self releaseCache
]

{ #category : #private }
BlHistogramGeometry >> vertices [

	^ pathCache geometryPath ifNil: [

		| origin delta direction vertices |
		origin := self origin.
		delta := self delta.
		direction := self direction.

		vertices := Array streamContents: [ :stream |
			stream nextPut: origin.

			self values inject: origin into: [ :currentPoint :each |
				| aNewY |
				aNewY := currentPoint + delta.
				stream
					nextPut: currentPoint + (direction * each * self extent);
					nextPut: aNewY + (direction * each * self extent).
				aNewY ].

			stream nextPut: origin + (delta normalized * self extent) ].

		pathCache geometryPath: vertices.

		vertices ]
]
