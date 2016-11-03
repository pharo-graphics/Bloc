morphic events handling
handleAnnouncements
	self
		onAnnouncement: WindowClosed
		do: [ :evt | BlMorphicWindowCloseEvent new sentTo: self internalEventHandler ].
	self
		onAnnouncement: WindowResizing
		do: [ :evt | 
			BlMorphicWindowResizeEvent new
				width: evt newSize x;
				height: evt newSize y;
				sentTo: self internalEventHandler ]