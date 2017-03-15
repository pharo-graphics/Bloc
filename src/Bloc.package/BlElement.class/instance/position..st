accessing
position: aPoint
	"Change position property without requesting layout update.
	This is not preferrable way to relocating and element, instead consider using #relocate:"

	self position: aPoint extent: self extent