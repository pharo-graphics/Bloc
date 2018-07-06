text - attributes
clearAttributes: aFromIndex to: aToIndex if: aBlock
	text
		clearAttributes: start + aFromIndex - 1
		to: start + aToIndex - 1
		if: aBlock