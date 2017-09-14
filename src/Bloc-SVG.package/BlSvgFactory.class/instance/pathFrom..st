path
pathFrom: node
	|path|
	path :=(BlSvgPath fromStream: (node attributeAt:'d')) asElement.
	
	self allPropertiesFrom: node attributes on: path.
	
	^path