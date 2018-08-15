initialization
initialize
	super initialize.
	
	overlayListener := BlOverlayListener for: self.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self preventMouseEvents