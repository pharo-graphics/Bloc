api - scrolling notifying
dispatchOnScrolled: aPoint

	dispatchScrollCounter := dispatchScrollCounter + 1.
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint.
	
	dispatchScrollCounter := dispatchScrollCounter - 1