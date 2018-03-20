initialization
initialize
	super initialize.
	
	overlayListener := BlOverlayListener for: self.
	self preventMouseEvents