line
lineFrom: node
	|line|
	line := BlLineElement new.
	line fromAnchor: (BlAbsolutePositionAnchor position: (self lineStartingPointFrom: node));
		toAnchor: (BlAbsolutePositionAnchor position: (self lineEndingPointFrom: node)).
	
	self allPropertiesFrom: node attributes on: line.
	
	^line
