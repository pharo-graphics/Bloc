*Bloc-SVG
inheriteTransformAttribute
	self parent attributeAt: 'transform' ifAbsent: [ ^ self ].
	
	self attributeAt: 'transform' put: (self parent attributeAt: 'transform') , self transformAttribute