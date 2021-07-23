Class {
	#name : 'BlNewLayoutNodeNoDecoration',
	#superclass : 'BlNewLayoutNodeDecoration',
	#type : 'variable',
	#category : 'Bloc-Layouts-Model-New'
}

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> getExtentOf: aLayoutNode [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ aLayoutNode privateExtent
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> getLayoutBoundsOf: aLayoutNode [
	<return: #BlBounds>

	^ BlBounds
		origin: aLayoutNode privatePosition
		extent: aLayoutNode privateExtent
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> getPositionOf: aLayoutNode [
	"Return position of the top left corner in the parent coordinate system"
	<return: #Point>

	^ aLayoutNode privatePosition
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> measure: anExtentSpecOrBlock of: aLayoutNode [
	aLayoutNode privateMeasure: anExtentSpecOrBlock
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode [
	aLayoutNode privateMeasurement: aBlLayoutNodeMeasurement
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> setPosition: aPoint of: aLayoutNode [
	"Set position of the top left corner in the parent coordinate system"

	aLayoutNode privatePosition: aPoint
]

{ #category : 'api - decoration' }
BlNewLayoutNodeNoDecoration >> transformationDo: aBlock [
]
