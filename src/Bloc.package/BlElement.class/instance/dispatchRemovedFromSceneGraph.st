children dispatching
dispatchRemovedFromSceneGraph
	"Sent after any of my parents or I was removed from scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onRemovedFromSceneGraph.
	self childrenDo: [ :anElement | anElement dispatchRemovedFromSceneGraph ]