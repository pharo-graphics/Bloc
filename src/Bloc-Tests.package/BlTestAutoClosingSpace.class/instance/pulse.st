pulse
pulse
	super pulse.
	
	frameCounter := frameCounter + 1.
	frameCounter >= frames
		ifTrue: [ self close ].