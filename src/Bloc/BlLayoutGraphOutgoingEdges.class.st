Class {
	#name : 'BlLayoutGraphOutgoingEdges',
	#superclass : 'BlLayoutGraphEdgesIterator',
	#package : 'Bloc',
	#tag : 'Layouts-Model'
}

{ #category : 'api - enumeration' }
BlLayoutGraphOutgoingEdges >> do: aBlock [
	"Evaluate a given block with all outgoing edges to the layout node"

	self layoutNode connectedEdges do: [ :eachLayoutEdge |
		(eachLayoutEdge fromNode = self layoutNode)
			ifTrue: [ aBlock value: eachLayoutEdge ] ]
]
