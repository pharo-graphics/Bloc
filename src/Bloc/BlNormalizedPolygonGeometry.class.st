Class {
	#name : 'BlNormalizedPolygonGeometry',
	#superclass : 'BlElementVectorGeometry',
	#instVars : [
		'vertices'
	],
	#category : 'Bloc-Basic-Geometry'
}

{ #category : 'accessing' }
BlNormalizedPolygonGeometry class >> vertices: aCollectionOfNormalizedPoints [
	^ self new vertices: aCollectionOfNormalizedPoints
]

{ #category : 'initialization' }
BlNormalizedPolygonGeometry >> initialize [
	super initialize.
	
	vertices := #()
]

{ #category : 'geometry' }
BlNormalizedPolygonGeometry >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : 'accessing' }
BlNormalizedPolygonGeometry >> vertices [
	<return: #Collection of: #Point>

	^ vertices
]

{ #category : 'accessing' }
BlNormalizedPolygonGeometry >> vertices: anObject [
	vertices := anObject
]
