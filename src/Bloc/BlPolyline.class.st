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
	#name : #BlPolyline,
	#superclass : #BlGeometry,
	#instVars : [
		'vertices'
	],
	#category : 'Bloc-Basic'
}

{ #category : #'instance creation' }
BlPolyline class >> vertices: aCollection [
	^ self new vertices: aCollection
]

{ #category : #converting }
BlPolyline >> asElement [
	^ super asElement
		background: Color transparent;
		outskirts: BlOutskirts centered
]

{ #category : #'geometry testing' }
BlPolyline >> containsPoint: aPoint in: anElement on: aSpartaCanvas [
	"Note: I am a fallback method to determine if a point lies within a geometry path
	when geometry is complex and it is mathematically difficult to compute manually"
	<return: #Boolean>
	| aPath |

	aPath := pathCache pathOnSpartaCanvas: aSpartaCanvas.
	^ aSpartaCanvas stroke
		path: aPath;
		width: anElement border width;
		containsPoint: aPoint
]

{ #category : #'geometry bounds' }
BlPolyline >> geometryBounds: aBounds [
	"Load my bounds in mutable rectangle.
	@see #geometryBounds for more info"
	<return: #BlBounds>

	^ aBounds
		origin: self vertices min
		corner: self vertices max
]

{ #category : #geometry }
BlPolyline >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlPolyline >> vertices [
	<return: #SequenceableCollection of: #Point>

	^ vertices
]

{ #category : #accessing }
BlPolyline >> vertices: aCollectionOfPoints [

	vertices := aCollectionOfPoints.
	extent := vertices max.
]
