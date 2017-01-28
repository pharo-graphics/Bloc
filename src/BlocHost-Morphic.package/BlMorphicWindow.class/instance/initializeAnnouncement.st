initialization
initializeAnnouncement
	self
		onAnnouncement: WindowClosed
		do: [ :evt | BlMorphicWindowCloseEvent new sentTo: eventHandler ].
	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			self resizeDuring: [ BlMorphicWindowResizeEvent new
				width: self spaceExtent x;
				height: self spaceExtent y;
				sentTo: eventHandler ] ]