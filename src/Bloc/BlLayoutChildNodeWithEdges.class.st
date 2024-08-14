Class {
	#name : #BlLayoutChildNodeWithEdges,
	#superclass : #BlLayoutNonLeafChildNode,
	#instVars : [
		'connectedEdges'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> addConnectedEdge: anEdge [

	(connectedEdges includes: anEdge) ifFalse: [
		connectedEdges add: anEdge ]
]

{ #category : #accessing }
BlLayoutChildNodeWithEdges >> connectedEdges [

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

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> nodesAlongIncomingEdges [
	"Answer a `BlLayoutGraphConnectedNodes`"

	^ self incomingEdges nodes
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> nodesAlongOutgoingEdges [
	"Answer a `BlLayoutGraphConnectedNodes`"

	^ self outgoingEdges nodes
]

{ #category : #'api - edges' }
BlLayoutChildNodeWithEdges >> outgoingEdges [

	^ (BlLayoutGraphConnectedEdges on: self) outgoing
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

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withEdges: aCollectionOfLayoutEdges [

	^ self
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withTransformation: aBlElementTransformation [

	^ self class new
		  childNode:
			  (childNode withTransformation: aBlElementTransformation);
		  connectedEdges: connectedEdges;
		  yourself
]

{ #category : #converting }
BlLayoutChildNodeWithEdges >> withoutTransformation [

	^ self class new
		  childNode: childNode withoutTransformation;
		  connectedEdges: connectedEdges;
		  yourself
]
