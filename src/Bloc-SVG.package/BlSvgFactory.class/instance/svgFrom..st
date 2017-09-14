groups
svgFrom: node
	|rootElement|
	rootElement := self gFrom: node.
	self positionFrom: node on: rootElement.
	self extentFrom: node on: rootElement.
	self viewBoxFrom: node on: rootElement.
	
	^rootElement