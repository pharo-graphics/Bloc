enumerating
allSpacesDo: aBlock
	"Evaluate a block with every space managed by space manager as argument"

	self spaceManager spaces do: aBlock