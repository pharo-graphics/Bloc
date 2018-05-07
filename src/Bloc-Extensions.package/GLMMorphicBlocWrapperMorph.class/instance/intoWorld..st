announcements
intoWorld: aWorld
	super intoWorld: aWorld.
	
	self window
		ifNil: [ ^ self ].
	
	self onAddedToWindow