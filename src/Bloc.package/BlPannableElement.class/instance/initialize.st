initialization
initialize
	super initialize.
	
	self alignCenter.
	
	zoomableElement := BlZoomableElement new.
	self addChild: zoomableElement