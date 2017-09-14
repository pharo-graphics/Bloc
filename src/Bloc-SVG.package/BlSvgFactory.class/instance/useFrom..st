definitions
useFrom: node
	| element |
	element := ( self definitions at: ( (node attributeAt:'xlink:href') withoutPrefix:'#' ) ) veryDeepCopy.
	element parent:nil.
	
	self positionFrom: node on: element.
	self extentFrom: node on: element.
	self allPropertiesFrom: node attributes on: element.
	
	^element