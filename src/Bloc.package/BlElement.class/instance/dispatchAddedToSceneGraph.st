children dispatching
dispatchAddedToSceneGraph
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onAddedToSceneGraph.
	self childrenDo: [ :anElement | anElement dispatchAddedToSceneGraph ]