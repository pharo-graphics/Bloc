Class {
	#name : 'BlNormalizedPolygon',
	#superclass : 'BlElementVectorGeometry',
	#instVars : [
		'vertices'
	],
	#category : 'Bloc-Basic'
}

{ #category : 'accessing' }
BlNormalizedPolygon class >> vertices: aCollectionOfNormalizedPoints [
	^ self new vertices: aCollectionOfNormalizedPoints
]

{ #category : 'initialization' }
BlNormalizedPolygon >> initialize [
	super initialize.
	
	vertices := #()
]

{ #category : 'geometry' }
BlNormalizedPolygon >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : 'accessing' }
BlNormalizedPolygon >> vertices [
	<return: #Collection of: #Point>

	^ vertices
]

{ #category : 'accessing' }
BlNormalizedPolygon >> vertices: anObject [
	vertices := anObject
]
