text - attributes
attributes: anAttributesCollection from: aFromIndex to: aToIndex 
	self text
		attributes: anAttributesCollection
		from: start + aFromIndex - 1
		to: start + aToIndex - 1