Class {
	#name : #BlLayoutChildNodeWithEdges,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'childNode',
		'connectedEdges'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> addConnectedEdge: anEdge [
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> childNode: aBlLayoutChildNode [
	childNode := aBlLayoutChildNode
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> children [
	^ { childNode }
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> connectedEdges [
	<return: #Collection of: #BlLayoutEdge>

	^ connectedEdges
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> connectedEdges: aCollectionOfLayoutEdges [
	connectedEdges := aCollectionOfLayoutEdges asOrderedCollection
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> connectedNodes [
	^ (BlLayoutGraphConnectedEdges on: self) nodes
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> constraints [
	^ childNode constraints
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> constraints: aBlLayoutConstraints [
	childNode constraints: aBlLayoutConstraints
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> hasNodesAlongIncomingEdges [
	<return: #Boolean>

	^ self nodesAlongIncomingEdges isNotEmpty
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> hasNodesAlongOutgoingEdges [
	<return: #Boolean>

	^ self nodesAlongOutgoingEdges isNotEmpty
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> incomingEdges [
	^ (BlLayoutGraphConnectedEdges on: self) incoming
]

{ #category : #initialization }
BlLayoutChildNodeWithEdges >> initialize [
	super initialize.
	
	connectedEdges := OrderedCollection new
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> layoutBounds [
	<return: #BlBounds>

	^ childNode layoutBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> layoutBounds: aBlLayoutBounds [
	childNode layoutBounds: aBlLayoutBounds
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithEdges >> measure: anExtentSpec [
	childNode measure: anExtentSpec
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ childNode measuredBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtentInLocal>

	^ childNode measuredExtent
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> measurement [
	<return: #BlLayoutNodeMeasurement>

	^ childNode measurement
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> measurement: aBlLayoutNodeMeasurement [
	childNode measurement: aBlLayoutNodeMeasurement
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> nodesAlongIncomingEdges [
	<return: #BlLayoutGraphConnectedNodes>

	^ self incomingEdges nodes
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> nodesAlongOutgoingEdges [
	<return: #BlLayoutGraphConnectedNodes>

	^ self outgoingEdges nodes
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> outgoingEdges [
	^ (BlLayoutGraphConnectedEdges on: self) outgoing
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> parent [
	<return: #BlLayoutParentNode>

	^ childNode parent
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> parent: aBlLayoutParentNode [
	childNode parent: aBlLayoutParentNode
]

{ #category : #printing }
BlLayoutChildNodeWithEdges >> printOn: aStream [
	aStream
		nextPutAll: 'Edges: ';
		print: self connectedEdges size;
		nextPutAll: ' incoming: ';
		print: self incomingEdges size;
		nextPutAll: ' outgoing: ';
		print: self outgoingEdges size
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> userData [
	<return: #Dictionary>
	
	^ childNode userData
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withEdges: aCollectionOfLayoutEdges [
	^ self
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withElement: aBlElement [
	^ BlLayoutChildNodeWithElement new
		childNode: self;
		element: aBlElement
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withTransformation: aBlElementTransformation [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		transformation:  aBlElementTransformation
]
