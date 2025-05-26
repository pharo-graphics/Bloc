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
		'BottomToTop',
		'LeftToRight',
		'RightToLeft',
		'TopToBottom'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'class initialization' }
BlHistogramGeometry class >> initialize [

	LeftToRight := #leftToRight.
	RightToLeft := #rightToLeft.
	BottomToTop := #bottomToTop.
	TopToBottom := #topToBottom
]

{ #category : #accessing }
BlHistogramGeometry >> beBottomToTop [

	orientation := BottomToTop.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beLeftToRight [

	orientation := LeftToRight.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beRightToLeft [

	orientation := RightToLeft.
	self releaseCache
]

{ #category : #accessing }
BlHistogramGeometry >> beTopToBottom [

	orientation := TopToBottom.
	self releaseCache
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> computeDelta [

	(self isLeftToRight or: [ self isRightToLeft ]) ifTrue: [
		^ 0 @ (self extent y / self values size) asFloat ].
	(self isTopToBottom or: [ self isBottomToTop ]) ifTrue: [
		^ (self extent x / self values size) asFloat @ 0 ].

	^ 0 @ 0
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> computeLengthVector [

	self isLeftToRight ifTrue: [ ^ 1 @ 0 ].
	self isRightToLeft ifTrue: [ ^ -1 @ 0 ].
	self isTopToBottom ifTrue: [ ^ 0 @ 1 ].
	self isBottomToTop ifTrue: [ ^ 0 @ -1 ].

	^ 0 @ 0
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> computeOrigin [

	self isLeftToRight ifTrue: [ ^ 0 @ 0 ].
	self isRightToLeft ifTrue: [ ^ self extent x @ 0 ].
	self isTopToBottom ifTrue: [ ^ 0 @ 0 ].
	self isBottomToTop ifTrue: [ ^ 0 @ self extent y ].

	^ 0 @ 0
]

{ #category : #accessing }
BlHistogramGeometry >> computedVertices [

	| anOrigin aDelta aLengthVector |
	anOrigin := self computeOrigin asFloatPoint.
	aDelta := self computeDelta.
	aLengthVector := self computeLengthVector.

	^ Array streamContents: [ :stream |
		stream nextPut: anOrigin.

		self values inject: anOrigin into: [ :currentPoint :eachValue |
			| aNewY |
			aNewY := currentPoint + aDelta.
			stream
				nextPut: currentPoint + (aLengthVector * eachValue * self extent);
				nextPut: aNewY + (aLengthVector * eachValue * self extent).
			aNewY ].

		stream nextPut: anOrigin + (aDelta normalized * self extent) ]
]

{ #category : #'geometry testing' }
BlHistogramGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	Assume aPoint is already inside the geometry bounds rectangle."
	
	^ BlPolygonHitTester doPolygonBy: self computedVertices include: aPoint
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
	orientation := BottomToTop
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> isBottomToTop [

	^ orientation = BottomToTop
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> isLeftToRight [

	^ orientation = LeftToRight
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> isRightToLeft [

	^ orientation = RightToLeft
]

{ #category : #'private - geometry' }
BlHistogramGeometry >> isTopToBottom [

	^ orientation = TopToBottom
]

{ #category : #geometry }
BlHistogramGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
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
