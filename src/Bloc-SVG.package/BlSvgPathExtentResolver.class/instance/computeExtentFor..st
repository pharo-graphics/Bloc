computing
computeExtentFor: aCollectionOfCmd
	aCollectionOfCmd do: [ :cmd | self perform: cmd first withArguments: cmd second ].
	extent := maxPoint - minPoint.