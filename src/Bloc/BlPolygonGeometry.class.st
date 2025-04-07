"
Example:

BlPolygon vertices: { 
	10@50.
	50@20.
	150@40.
	180@150.
	80@140
}
"
Class {
	#name : #BlPolygonGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlPolygonGeometry class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #comparing }
BlPolygonGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self vertices = anObject vertices
]

{ #category : #'geometry testing' }
BlPolygonGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry."

	^ BlPolygonHitTester doPolygonBy: self vertices include: aPoint
]

{ #category : #'api - bounds' }
BlPolygonGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: (self vertices ifEmpty: [0@0] ifNotEmpty: [self vertices min])
		corner: (self vertices ifEmpty: [0@0] ifNotEmpty: [self vertices max])
]

{ #category : #testing }
BlPolygonGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlPolygonGeometry >> hasJoins [

	^ true
]

{ #category : #initialization }
BlPolygonGeometry >> initialize [ 

	super initialize.
	vertices := #()
]

{ #category : #geometry }
BlPolygonGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolygonGeometry >> vertices [

	^ vertices
]

{ #category : #accessing }
BlPolygonGeometry >> vertices: aCollectionOfPoints [
	| theNewVertices |
	theNewVertices := aCollectionOfPoints collect: [ :eachPoint | eachPoint asFloatPoint ].
	
	theNewVertices = vertices
		ifTrue: [ ^ self ].
	
	vertices := theNewVertices.
	extent := vertices ifEmpty: [ 0@0 ] ifNotEmpty: [vertices max].
	self releaseCache
]
