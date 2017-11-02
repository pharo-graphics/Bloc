children hooks
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.
	
	paragraph
		ifNil: [ ^ self ].

	paragraph wantsAutoRelease
		ifFalse: [ paragraph finalize ]