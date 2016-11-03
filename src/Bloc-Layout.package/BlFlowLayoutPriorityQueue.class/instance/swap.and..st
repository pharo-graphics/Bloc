private
swap: aNodeA and: aNodeB
	| index |
	
	nodes at: aNodeA queueIndex put: aNodeB.
	nodes at: aNodeB queueIndex put: aNodeA.
	
	index := aNodeA queueIndex.
	aNodeA queueIndex: aNodeB queueIndex.
	aNodeB queueIndex: index