rectangle
rectFrom: node
	|rectangle|
	rectangle := ( (BlRectangle extent: (node attributeAt:'width') asNumber @ ((node attributeAt:'height') asNumber))
		cornerRadius: (self rectCornerRadiusFrom: node);
		yourself ) asElement.
	self positionFrom:node on:rectangle.
	
	self allPropertiesFrom: node attributes on: rectangle.
	
	^rectangle