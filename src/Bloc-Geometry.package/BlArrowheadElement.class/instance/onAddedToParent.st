children hooks
onAddedToParent
	super onAddedToParent.
	
	self parent addEventHandler: borderListener.
	self handleWidthChanged: self parent border width