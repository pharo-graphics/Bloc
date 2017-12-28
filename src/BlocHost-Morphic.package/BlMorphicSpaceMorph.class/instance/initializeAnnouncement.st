initialization
initializeAnnouncement
	self
		onAnnouncement: WindowOpened
		do: [ :anEvent | BlMorphicWindowOpenedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: WindowClosed
		do: [ :anEvent | BlMorphicWindowClosedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphOpened
		do: [ :anEvent | BlMorphicWindowOpenedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphDeleted
		do: [ :anEvent | BlMorphicWindowClosedEvent new sentTo: eventHandler ].

	self
		onAnnouncement: MorphGotFocus
		do: [ :evt | ].

	self
		onAnnouncement: MorphLostFocus
		do: [ :evt | ].

	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			self resizeDuring: [
				BlMorphicWindowResizeEvent new
					width: self width;
					height: self height;
					sentTo: eventHandler ] ]