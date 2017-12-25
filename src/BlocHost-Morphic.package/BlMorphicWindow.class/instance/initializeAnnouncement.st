initialization
initializeAnnouncement
	self
		onAnnouncement: WindowOpened
		do: [ :anEvent |
			BlMorphicWindowOpenedEvent new sentTo: eventHandler.
			spaceForm startStepping ].

	self
		onAnnouncement: WindowClosed
		do: [ :anEvent |
			spaceForm stopStepping.
			BlMorphicWindowClosedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphGotFocus
		do: [ :evt | ].

	self
		onAnnouncement: MorphLostFocus
		do: [ :evt | ].

	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			self resizeDuring: [ BlMorphicWindowResizeEvent new
				width: self spaceExtent x;
				height: self spaceExtent y;
				sentTo: eventHandler ] ]