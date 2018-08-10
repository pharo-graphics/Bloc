hooks - children
onRemovedFromSceneGraph
	super onRemovedFromSceneGraph.

	self fireEvent: (BlTextCursorRemovedFromTheSceneEvent new cursorElement: self)