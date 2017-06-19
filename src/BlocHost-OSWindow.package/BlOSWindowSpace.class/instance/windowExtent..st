host space - accessing
windowExtent: newExtent
	"Change window size to a newExtent"

	self windowExtent ~= newExtent
		ifTrue: [ window extent: newExtent ]