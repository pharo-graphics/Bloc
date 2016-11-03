initialization
initialize
	super initialize.
	
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.
	measurer := BlFlowLayoutMeasurer for: self.
	self orientation: self defaultOrientation