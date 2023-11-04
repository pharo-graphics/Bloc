Class {
	#name : #BlLayoutGraphConnectedNodes,
	#superclass : #BlLayoutGraphIterator,
	#instVars : [
		'edges'
	],
	#category : 'Bloc-Layouts-Model'
}

{ #category : 'instance creation' }
BlLayoutGraphConnectedNodes class >> on: aLayoutNode from: theLayoutEdges [
	^ (self on: aLayoutNode) initializeWith: theLayoutEdges
]

{ #category : 'api - enumeration' }
BlLayoutGraphConnectedNodes >> do: aBlock [
	edges do: [ :eachLayoutEdge |
		"we don't want to include a node from which we asked for edges"
		(eachLayoutEdge fromNode ~= self layoutNode)
			ifTrue: [ aBlock value: eachLayoutEdge fromNode ].
		(eachLayoutEdge toNode ~= self layoutNode)
			ifTrue: [ aBlock value: eachLayoutEdge toNode ] ]
]

{ #category : 'initialization' }
BlLayoutGraphConnectedNodes >> initializeWith: theLayoutEdges [
	edges := theLayoutEdges
]
