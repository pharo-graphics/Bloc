api - tasks
enqueueTask: aBlTask
	aBlTask onEnqueuedInElement: self.
	self isAttachedToSceneGraph
		ifTrue: [ self space enqueueTask: aBlTask ]
		ifFalse: [ self taskQueue enqueue: aBlTask ]