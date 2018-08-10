hooks - children
onAddedToSceneGraph
	super onAddedToSceneGraph.

	self fireEvent: (BlTextCursorAddedToTheSceneEvent new cursorElement: self)