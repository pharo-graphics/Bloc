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

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ childNode extent
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> hasNodesAlongIncomingEdges [

	^ self nodesAlongIncomingEdges isNotEmpty
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> hasNodesAlongOutgoingEdges [

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

{ #category : #'api - measure' }
BlLayoutChildNodeWithEdges >> measure: anExtentSpecOrBlock [
	childNode measure: anExtentSpecOrBlock
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

{ #category : #'api - actions' }
BlLayoutChildNodeWithEdges >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ childNode popAction
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ childNode position
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithEdges >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	
	childNode position: aPoint
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
BlLayoutChildNodeWithEdges >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ childNode privateMeasurement
]

{ #category : #'api - actions' }
BlLayoutChildNodeWithEdges >> pushAction: aBlLayoutNodeElementAction [
	childNode pushAction: aBlLayoutNodeElementAction
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> transformationDo: aBlock [
	childNode transformationDo: aBlock
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
	^ self class new
		childNode: (childNode withTransformation: aBlElementTransformation);
		connectedEdges: connectedEdges
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withoutTransformation [
	^ self class new
		childNode: childNode withoutTransformation;
		connectedEdges: connectedEdges
]
