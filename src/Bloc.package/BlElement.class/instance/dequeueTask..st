api - tasks
dequeueTask: aBlTask

	self isAttachedToSceneGraph
		ifTrue: [ self space dequeueTask: aBlTask ]
		ifFalse: [ self taskQueue dequeue: aBlTask ]