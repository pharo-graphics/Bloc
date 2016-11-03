pulse
applyValue: aValue
	|oldExtent tslt|
	oldExtent := self target txBounds extent.
	self target scaleTo: aValue.
	tslt := self target txBounds extent - oldExtent.
	self target relocate: self target position - (tslt/2).
	
	
	