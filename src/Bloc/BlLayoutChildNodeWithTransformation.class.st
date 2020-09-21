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
BlLayoutChildNodeWithTransformation >> layoutBounds [
	<return: #BlBounds>

	^ childNode layoutBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> layoutBounds: aBlLayoutBounds [
	childNode layoutBounds: aBlLayoutBounds.

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: self layoutBounds extent)
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> matrix: aBlMatrix [
	self transformation: (BlElementAbsoluteTransformation matrix: aBlMatrix)
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithTransformation >> measure: anExtentSpec [
	childNode measure: anExtentSpec.

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent)
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ BlLayoutBoundsInLocal new
		position: self measurement position;
		extent: self measurement extent;
		transformation: self transformation
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtent>

	^ BlLayoutExtentInLocalWithTransformation new
		size: self measurement extent;
		transformation: self transformation
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> measurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ childNode measurement
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> measurement: aBlLayoutNodeMeasurement [
	childNode measurement: aBlLayoutNodeMeasurement.

	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before measurement' ].

	self transformation bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent)
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
		bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent)
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
