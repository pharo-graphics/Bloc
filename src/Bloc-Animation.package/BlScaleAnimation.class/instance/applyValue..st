pulse
applyValue: aValue
	| oldExtent tslt |
	oldExtent := self target transformedBounds extent.
	self target scaleTo: aValue.
	tslt := self target transformedBounds extent - oldExtent.
	self target relocate: self target position - (tslt/2)