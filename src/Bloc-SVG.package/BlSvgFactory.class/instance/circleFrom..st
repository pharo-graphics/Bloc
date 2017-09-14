circle & ellipse
circleFrom: node
	node attributeAt:'rx' put: (node attributeAt:'r').
	node attributeAt:'ry' put: (node attributeAt:'r').
	^self ellipseFrom: node.