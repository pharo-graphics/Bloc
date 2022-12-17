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

{ #category : #converting }
BlPolylineGeometry >> asElement [
	^ super asElement
		background: Color transparent;
		outskirts: BlOutskirts centered
]

{ #category : #'geometry bounds' }
BlPolylineGeometry >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
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
