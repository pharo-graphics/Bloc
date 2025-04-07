Class {
	#name : #BlSquareGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'length',
		'origin'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #comparing }
BlSquareGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlSquareGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [

	^ true
]

{ #category : #'geometry bounds' }
BlSquareGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: self origin
		extent: (self length * 2.0) asPoint
]

{ #category : #testing }
BlSquareGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlSquareGeometry >> hasJoins [

	^ true
]

{ #category : #accessing }
BlSquareGeometry >> length [
	^ length
]

{ #category : #geometry }
BlSquareGeometry >> matchExtent: anExtent [
	length := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlSquareGeometry >> origin [
	^ origin
]
