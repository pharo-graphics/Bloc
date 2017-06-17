host space - accessing
windowExtent: newExtent
	"Change window size to a newExtent"

	self windowExtent ~= newExtent
		ifTrue: [ window extent: newExtent ].

	"we must always let renderer now that size changed
	(dpi might changed, even if extent is still the same)"
	renderer renderer resized