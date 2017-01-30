initialization
initializeAnnouncement
	
	self
		onAnnouncement: WindowOpened
		do: [ :evt | spaceForm startStepping ].

	self
		onAnnouncement: WindowClosed
		do: [ :evt | spaceForm stopStepping. BlMorphicWindowCloseEvent new sentTo: eventHandler ].
		
	
	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			self resizeDuring: [ BlMorphicWindowResizeEvent new
				width: self spaceExtent x;
				height: self spaceExtent y;
				sentTo: eventHandler ] ]