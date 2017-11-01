accessing
nodesAt: aPoint in: aCollection
	self nodes
		reverseDo: [ :aNode | aNode nodesAt: aPoint in: aCollection ]