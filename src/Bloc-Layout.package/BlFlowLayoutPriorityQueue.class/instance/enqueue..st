add / remove
enqueue: anObject
	| priority node |
	priority := priorityBlock value: anObject.
	
	node := BlFlowLayoutPriorityQueueNode new.
	node value: anObject.
	node priority: priority.
	
	nodes add: node.
	
	totalSize := totalSize + 1.
	node insertionIndex: totalSize.
	node queueIndex: self size.
	
	self cascadeUp: node.

	^ node