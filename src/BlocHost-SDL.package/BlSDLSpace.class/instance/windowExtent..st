accessing
windowExtent: newExtent
	"Change window size to a newExtent"

	self windowExtent ~= newExtent
		ifTrue: [ sdlWindow setSizeW: newExtent x h: newExtent y ].
	renderer resized