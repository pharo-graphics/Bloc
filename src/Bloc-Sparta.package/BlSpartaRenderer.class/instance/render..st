renderer - rendering
render: aSpace
	"Render a given space according to its dirty areas.
	Note: if there are no dirty areas nothing will happen, including window or canvas update"
	
	(self renderNeeded: aSpace)
		ifFalse: [ ^ self ].

	self prepareToRender: aSpace.
	 [ self doRender: aSpace ]
		ensure: [ self finishedRender: aSpace ]