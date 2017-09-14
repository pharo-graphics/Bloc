text
textFrom: node
	|textElement|
	textElement := self gFrom: node.
	textElement addChild: (self tspanFrom: node).
	
	^textElement