manager -> element
addChild: anElement at: anIndex
	infiniteElement addChild: anElement at: anIndex.
	infiniteElement dispatchChildAttached: anElement