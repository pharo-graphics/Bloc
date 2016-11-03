add / remove
remove: aNode
	<return: #BlFlowLayoutPriorityQueueNode>
	
	| formerLastNode |
	
	(aNode queueIndex = self size)
		ifTrue: [ ^ nodes removeLast value ].

	formerLastNode := nodes last.
	self swap: aNode and: formerLastNode.
	nodes removeLast.
	
	self nodeUpdated: formerLastNode.
	^ aNode value