Class {
	#name : #BlLayoutGraphIncomingEdges,
	#superclass : #BlLayoutGraphEdgesIterator,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - enumeration' }
BlLayoutGraphIncomingEdges >> do: aBlock [
	"Evaluate a given block with all incoming edges to the layout node"

	self layoutNode connectedEdges do: [ :eachLayoutEdge |
		(eachLayoutEdge toNode = self layoutNode)
			ifTrue: [ aBlock value: eachLayoutEdge ] ]
]
