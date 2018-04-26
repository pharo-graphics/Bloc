computing
computeExtentFor: aCollectionOfCmd
	aCollectionOfCmd do: [ :cmd | cmd executeOn: self ].
	extent := maxPoint - minPoint.