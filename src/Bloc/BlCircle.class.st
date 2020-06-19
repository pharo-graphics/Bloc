Class {
	#name : #BlCircle,
	#superclass : #BlGeometry,
	#instVars : [
		'radius',
		'origin'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'geometry bounds' }
BlCircle >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self origin
		extent: (self radius * 2.0) asPoint
]

{ #category : #initialization }
BlCircle >> initialize [
	super initialize.
	
	radius := 0.
	origin := 0@0
]

{ #category : #geometry }
BlCircle >> matchExtent: anExtent [
	radius := anExtent min / 2.0.
	origin := (anExtent - anExtent min asPoint) / 2.0.

	self extent: anExtent
]

{ #category : #accessing }
BlCircle >> origin [
	^ origin
]

{ #category : #accessing }
BlCircle >> radius [
	^ radius
]
