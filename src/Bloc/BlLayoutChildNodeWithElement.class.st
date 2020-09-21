"
!Layout node with an element
Is used to keep track of the child node and its associated element
"
Class {
	#name : #BlLayoutChildNodeWithElement,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'childNode',
		'element'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutChildNodeWithElement >> childNode: aBlLayoutChildNode [
	childNode := aBlLayoutChildNode
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> children [
	^ { childNode }
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> constraints [
	^ childNode constraints
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> constraints: aBlLayoutConstraints [
	childNode constraints: aBlLayoutConstraints
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> element [
	^ element
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> element: anObject [
	element := anObject
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> layoutBounds [
	<return: #BlBounds>

	^ childNode layoutBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> layoutBounds: aBlLayoutBounds [
	childNode layoutBounds: aBlLayoutBounds
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithElement >> measure: anExtentSpec [
	childNode measure: anExtentSpec
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ childNode measuredBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtentInLocal>

	^ childNode measuredExtent
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> measurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ childNode measurement
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> measurement: aBlLayoutNodeMeasurement [
	childNode measurement: aBlLayoutNodeMeasurement
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> parent [
	<return: #BlLayoutParentNode>

	^ childNode parent
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> parent: aBlLayoutParentNode [
	childNode parent: aBlLayoutParentNode
]

{ #category : #printing }
BlLayoutChildNodeWithElement >> printOn: aStream [
	aStream
		nextPutAll: 'Element position: ';
		print: self element measuredBounds position;
		nextPutAll: ' extent: ';
		print: self element measuredBounds extent
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> userData [
	<return: #Dictionary>
	
	^ childNode userData
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withEdges: aCollectionOfLayoutEdges [
	^ BlLayoutChildNodeWithEdges new
		childNode: self;
		connectedEdges: aCollectionOfLayoutEdges
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withElement: aBlElement [
	^ self
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withTransformation: aBlElementTransformation [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		transformation:  aBlElementTransformation
]

{ #category : #converting }
BlLayoutChildNodeWithElement >> withoutElement [
	^ childNode
]
