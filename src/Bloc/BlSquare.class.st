Class {
	#name : #BlSquare,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'length',
		'origin'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'geometry testing' }
BlSquare >> containsPoint: aPoint in: aBlElement [
	^ (self geometryBounds: BlBounds new) containsPoint: aPoint
]

{ #category : #'geometry bounds' }
BlSquare >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self origin
		extent: (self length * 2.0) asPoint
]

{ #category : #accessing }
BlSquare >> length [
	^ length
]

{ #category : #geometry }
BlSquare >> matchExtent: anExtent [
	length := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlSquare >> origin [
	^ origin
]
