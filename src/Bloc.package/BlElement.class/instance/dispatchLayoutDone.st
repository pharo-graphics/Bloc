layout
dispatchLayoutDone
	"Is sent when layout is done.
	Normally I am triggered by the space as soon as layout process is completed.
	I am recursively dispatched top-down through the scene graph and the whole composition tree of the elements.
	Layout done hook is essential for the implementation of so called `layout-once` layouts such as graph or visualisation layouts"

	self onLayoutDone.
	self layout onLayoutDone: self.
	self children do: [ :aChildElement | aChildElement dispatchLayoutDone ]