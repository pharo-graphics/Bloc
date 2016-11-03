as yet unclassified
computeExtentFor: aCollectionOfCmd
	aCollectionOfCmd do: [ :cmd | self perform: cmd first withArguments: cmd second ].
	extent := minPoint + maxPoint