"
I am a special type of a polyline whose vertices are within [0...1]@[0...1]

"
Class {
	#name : #BlNormalizedPolylineGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlNormalizedPolylineGeometry class >> vertices: aCollectionOfNormalizedPoints [
	^ self new vertices: aCollectionOfNormalizedPoints
]

{ #category : #initialization }
BlNormalizedPolylineGeometry >> initialize [
	super initialize.
	
	vertices := #()
]

{ #category : #geometry }
BlNormalizedPolylineGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlNormalizedPolylineGeometry >> vertices [
	^ vertices
]

{ #category : #accessing }
BlNormalizedPolylineGeometry >> vertices: anObject [
	vertices := anObject
]
