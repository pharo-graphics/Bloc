Class {
	#name : #BlNewLayoutNodeDecorationWithTransformation,
	#superclass : #BlNewLayoutNodeWrapperDecoration,
	#type : #variable,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #'api - transformation' }
BlNewLayoutNodeDecorationWithTransformation >> extentToParent: aPoint [
	<return: #Point>

	^ (self transformation transformBounds: (BlBounds origin: 0@0 extent: aPoint)) extent
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> getExtentOf: aLayoutNode [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ self extentToParent: (decoration getExtentOf: aLayoutNode)
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> getPositionOf: aLayoutNode [
	^ (decoration getPositionOf: aLayoutNode) + (self pointToParent: 0@0)
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> measure: anExtentSpecOrBlock of: aLayoutNode [
	decoration measure: anExtentSpecOrBlock of: aLayoutNode.

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: aLayoutNode privateMeasurement extent)
]

{ #category : #'api - transformation' }
BlNewLayoutNodeDecorationWithTransformation >> pointToLocal: aPoint [
	<return: #Point>

	^ self transformation inverseTransformPoint: aPoint
]

{ #category : #'api - transformation' }
BlNewLayoutNodeDecorationWithTransformation >> pointToParent: aPoint [
	<return: #Point>

	^ self transformation transformPoint: aPoint
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode [
	decoration setMeasurement: aBlLayoutNodeMeasurement of: aLayoutNode.

	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before measurement' ].

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: aLayoutNode privateMeasurement extent)
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> setPosition: aPoint of: aLayoutNode [
	decoration setPosition: (aPoint - (self pointToParent: 0@0)) of: aLayoutNode
]

{ #category : #accessing }
BlNewLayoutNodeDecorationWithTransformation >> setTransformation: aBlElementTransformation of: aLayoutNode [
	self
		assert: [ aBlElementTransformation notNil ]
		description: [ 'Transformation must not be nil' ].

	transformation := aBlElementTransformation asCachedTransformation
		bounds: (BlBounds origin: 0.0@0.0 extent: aLayoutNode privateMeasurement extent)
]

{ #category : #accessing }
BlNewLayoutNodeDecorationWithTransformation >> transformation [
	<return: #BlElementTransformation>
	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before accessing it' ].

	^ transformation
]

{ #category : #'api - decoration' }
BlNewLayoutNodeDecorationWithTransformation >> transformationDo: aBlock [
	aBlock value: transformation asElementTransformation
]
