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
BlLayoutChildNodeWithElement >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ childNode extent
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> layoutBounds [
	<return: #BlBounds>

	^ childNode layoutBounds
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithElement >> measure: anExtentSpec [
	childNode measure: anExtentSpec
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

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ childNode position
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithElement >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	childNode position: aPoint
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
BlLayoutChildNodeWithElement >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ childNode privateMeasurement
]

{ #category : #accessing }
BlLayoutChildNodeWithElement >> transformationDo: aBlock [
	childNode transformationDo: aBlock
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
