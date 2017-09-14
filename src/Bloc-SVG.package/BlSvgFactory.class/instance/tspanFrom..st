text
tspanFrom: node
	|textElement|
	self setAttributesForTextFrom: node.
	
	textElement := BlTextElement new constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ]; yourself.
	self ropedTextFrom:node on: textElement.
	self positionFrom: node on: textElement.
	
	self allPropertiesFrom: node attributes on: textElement.
	
	^textElement