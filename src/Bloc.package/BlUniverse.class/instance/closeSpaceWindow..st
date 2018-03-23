window managing
closeSpaceWindow: aSpace

	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	self
		assert: [ aSpace hasHostSpace ]
		description: [ 'Space must have a host! Are you sure it is opened?' ].

	"First destroy host space and "
	aSpace host destroyHostSpaceFor: aSpace.

	"then remove space itself from space manager"
	self spaceManager removeSpace: aSpace.
	
	"Notify root element that it is no longer in scene graph"
	aSpace root dispatchRemovedFromSceneGraph.
	"Send space closed event.
	Note: a new space may be spawned as a reaction to the event, that is why
	we send it before stopping host and universe"
	aSpace dispatchEvent: (BlSpaceClosedEvent new space: self).
	
	(self spaceManager spaces anySatisfy: [ :eachSpace | eachSpace host == aSpace host ])
		ifFalse: [ aSpace host isRunning ifTrue: [ aSpace host stop ] ].

	self
		assert: [ aSpace hasHostSpace not ]
		description: [ 'Host space must not have a host!' ].
		
	"Stop universe if there are no spaces left"
	self spaceManager hasSpaces
		ifFalse: [ self stop ]