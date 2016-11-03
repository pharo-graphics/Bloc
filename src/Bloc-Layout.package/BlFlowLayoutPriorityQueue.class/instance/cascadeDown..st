private
cascadeDown: aNode
	| finalQueueIndex newParentNode |
	finalQueueIndex := aNode queueIndex.
	newParentNode := nil.
	
	[ 
		| childLeftIndex childLeft childRightIndex |
		newParentNode := aNode.
		
		childLeftIndex := 2 * finalQueueIndex.
		
		(childLeftIndex > self size)
			ifTrue: [
				aNode queueIndex: finalQueueIndex.
				nodes at: finalQueueIndex put: aNode.
				^ self ].
		
		childLeft := nodes at: childLeftIndex.
		
		(self hasHigherPriority: childLeft than: newParentNode)
			ifFalse: [ newParentNode := childLeft ].
		
		childRightIndex := childLeftIndex + 1.
		childRightIndex <= self size ifTrue: [ 
			| childRight |
			childRight := nodes at: childRightIndex.
			(self hasHigherPriority: childRight than: newParentNode)
				ifFalse: [ newParentNode := childRight ] ].
		
		newParentNode == aNode
			ifFalse: [ 
				| index |
				nodes at: finalQueueIndex put: newParentNode.
				index := newParentNode queueIndex.
				newParentNode queueIndex: finalQueueIndex.
				finalQueueIndex := index	]
			ifTrue: [
				aNode queueIndex: finalQueueIndex.
				nodes at: finalQueueIndex put: aNode.
				^ self ].
	 ] repeat