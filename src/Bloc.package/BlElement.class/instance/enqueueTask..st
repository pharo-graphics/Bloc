api - tasks
enqueueTask: aBlTask

	self isAttachedToSceneGraph
		ifTrue: [ self space enqueueTask: aBlTask ]
		ifFalse: [ self taskQueue enqueue: aBlTask ]