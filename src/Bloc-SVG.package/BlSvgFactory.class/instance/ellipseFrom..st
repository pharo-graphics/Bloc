circle & ellipse
ellipseFrom: node
	|ellipse|
	ellipse := (BlEllipse extent: ( node attributeAt:'rx') asNumber *2 @ ((node attributeAt:'ry') asNumber *2)) asElement.
	ellipse position: (self ellipsePositionFrom: node).
	
	self allPropertiesFrom: node attributes on: ellipse.
	
	^ellipse