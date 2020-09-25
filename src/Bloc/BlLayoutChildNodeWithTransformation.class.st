Class {
	#name : #BlLayoutChildNodeWithTransformation,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'childNode',
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> childNode: aBlLayoutChildNode [
	childNode := aBlLayoutChildNode
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> children [
	^ { childNode }
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> constraints [
	^ childNode constraints
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> constraints: aBlLayoutConstraints [
	childNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ self extentToParent: childNode extent
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> extentToParent: aPoint [
	<return: #Point>

	^ (transformation transformBounds: (BlBounds origin: 0@0 extent: aPoint)) extent
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> layoutBounds [
	<return: #BlBounds>

	^ BlBounds
		origin: childNode position
		extent: self privateMeasurement extent
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> matrix: aBlMatrix [
	self transformation: (BlElementAbsoluteTransformation matrix: aBlMatrix)
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithTransformation >> measure: anExtentSpec [
	childNode measure: anExtentSpec.

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: self privateMeasurement extent)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> measurement: aBlLayoutNodeMeasurement [
	childNode measurement: aBlLayoutNodeMeasurement.

	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before measurement' ].

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: self privateMeasurement extent)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> parent [
	<return: #BlLayoutParentNode>

	^ childNode parent
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> parent: aBlLayoutParentNode [
	childNode parent: aBlLayoutParentNode
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> pointToLocal: aPoint [
	<return: #Point>

	^ self transformation inverseTransformPoint: aPoint
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> pointToParent: aPoint [
	<return: #Point>

	^ transformation transformPoint: aPoint
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> position [
	^ childNode position + (self pointToParent: 0@0)
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> position: aPoint [
	childNode position: aPoint - (self pointToParent: 0@0)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ childNode privateMeasurement
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformation [
	<return: #BlElementTransformation>
	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before accessing it' ].

	^ transformation
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformation: aBlElementTransformation [
	self
		assert: [ aBlElementTransformation notNil ]
		description: [ 'Transformation must not be nil' ].

	transformation := aBlElementTransformation asCachedTransformation
		bounds: (BlBounds origin: 0.0@0.0 extent: self privateMeasurement extent)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformationDo: aBlock [
	aBlock value: transformation asElementTransformation
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> userData [
	<return: #Dictionary>
	
	^ childNode userData
]

{ #category : #converting }
BlLayoutChildNodeWithTransformation >> withEdges: aCollectionOfLayoutEdges [
	^ BlLayoutChildNodeWithEdges new
		childNode: self;
		connectedEdges: aCollectionOfLayoutEdges
]

{ #category : #converting }
BlLayoutChildNodeWithTransformation >> withElement: aBlElement [
	^ BlLayoutChildNodeWithElement new
		childNode: self;
		element: aBlElement
]

{ #category : #converting }
BlLayoutChildNodeWithTransformation >> withTransformation: aBlElementTransformation [
	^ self
]
