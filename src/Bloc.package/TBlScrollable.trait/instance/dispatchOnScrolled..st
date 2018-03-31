api - scrolling notifying
dispatchOnScrolled: aPoint
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint