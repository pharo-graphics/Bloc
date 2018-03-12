children hooks
onAddedToParent
	super onAddedToParent.
	
	self parent addEventHandler: borderListener.
	self geometryChanged