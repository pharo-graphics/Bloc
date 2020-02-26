"
I am a special type of a polyline whose vertices are within [0...1]@[0...1]
"
Class {
	#name : #BlNormalizedPolyline,
	#superclass : #BlGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlNormalizedPolyline class >> vertices: aCollectionOfNormalizedPoints [
	^ self new vertices: aCollectionOfNormalizedPoints
]

{ #category : #initialization }
BlNormalizedPolyline >> initialize [
	super initialize.
	
	vertices := #()
]

{ #category : #geometry }
BlNormalizedPolyline >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlNormalizedPolyline >> vertices [
	^ vertices
]

{ #category : #accessing }
BlNormalizedPolyline >> vertices: anObject [
	vertices := anObject
]
