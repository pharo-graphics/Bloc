Class {
	#name : #BlLayoutGraphConnectedEdges,
	#superclass : #BlLayoutGraphEdgesIterator,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - enumeration' }
BlLayoutGraphConnectedEdges >> do: aBlock [
	"Evaluate a given block with all connected edges of the graph element"
	
	self layoutNode connectedEdges do: aBlock
]

{ #category : #'api - iterator' }
BlLayoutGraphConnectedEdges >> incoming [

	^ BlLayoutGraphIncomingEdges on: self layoutNode
]

{ #category : #'api - iterator' }
BlLayoutGraphConnectedEdges >> outgoing [

	^ BlLayoutGraphOutgoingEdges on: self layoutNode
]
