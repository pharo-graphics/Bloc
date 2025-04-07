"
Example:

BlPolyline vertices: { 
	10@50.
	50@20.
	150@40.
	180@150.
	80@140
}
"
Class {
	#name : #BlPolylineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlPolylineGeometry class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #comparing }
BlPolylineGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self vertices = anObject vertices
]

{ #category : #'geometry testing' }
BlPolylineGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	"Answer whether aPoint is contained by this geometry.
	
	Based on RSPolyline>>#basicIncludesPoint:"

	vertices overlappingPairsDo: [ :a :b | 
		(aPoint onLineFrom: a to: b within: aBlElement border width / 2) 
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'geometry bounds' }
BlPolylineGeometry >> geometryBounds: aBlBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"

	^ aBlBounds
		origin: self vertices min
		corner: self vertices max
]

{ #category : #testing }
BlPolylineGeometry >> hasCaps [

	^ true
]

{ #category : #testing }
BlPolylineGeometry >> hasJoins [

	^ vertices size > 2
]

{ #category : #geometry }
BlPolylineGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolylineGeometry >> vertices [
	<return: #SequenceableCollection of: #Point>

	^ vertices
]

{ #category : #accessing }
BlPolylineGeometry >> vertices: aCollectionOfPoints [

	vertices := aCollectionOfPoints.
	extent := vertices max.
]
