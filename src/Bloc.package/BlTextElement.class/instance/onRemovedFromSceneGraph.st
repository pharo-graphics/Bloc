children hooks
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.
	
	textLayout
		ifNil: [ ^ self ].

	textLayout wantsAutoRelease
		ifFalse: [ textLayout finalize ]