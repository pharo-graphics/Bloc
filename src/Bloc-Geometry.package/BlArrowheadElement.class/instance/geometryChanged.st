geometry hooks
geometryChanged

	self hasParent
		ifFalse: [ ^ self ].

	self handleWidthChanged: self parent border width