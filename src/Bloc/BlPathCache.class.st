"
I am responsible for caching backend specific geometry path of the element.
Geometry path is created with the help of backend-specific path builder by BlGeometry

"
Class {
	#name : #BlPathCache,
	#superclass : #Object,
	#instVars : [
		'session',
		'geometry',
		'geometryPath',
		'strokedBounds'
	],
	#category : 'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlPathCache class >> on: aGeometry [

	^ self new
		  geometry: aGeometry;
		  yourself
]

{ #category : #'session management' }
BlPathCache >> checkSession [

	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.
	self releaseCache
]

{ #category : #accessing }
BlPathCache >> geometry [
	"Return a `BlElementVectorGeometry` whose path I cache."

	^ geometry
]

{ #category : #accessing }
BlPathCache >> geometry: aBlGeometry [
	"Attach a geometry which path I should cache"

	geometry := aBlGeometry
]

{ #category : #accessing }
BlPathCache >> geometryPath [

	^ geometryPath
]

{ #category : #accessing }
BlPathCache >> geometryPath: anObject [

	geometryPath := nil
]

{ #category : #'session management' }
BlPathCache >> releaseCache [
	"Release path caches requiring their fresh creation"

	geometryPath := nil.
	self releaseStrokedBoundsCache
]

{ #category : #'session management' }
BlPathCache >> releaseStrokedBoundsCache [
	"Release stroked bounds to force its recomputation"

	strokedBounds := nil
]

{ #category : #accessing }
BlPathCache >> strokedBounds: aBlBounds of: anElement [
	"Return stroked bounds of a geometry if it would be stroked according to element's outskirts."

	^ strokedBounds ifNil: [
		strokedBounds := anElement outskirts
			strokedBounds: BlBounds new
			of: anElement ]
]
