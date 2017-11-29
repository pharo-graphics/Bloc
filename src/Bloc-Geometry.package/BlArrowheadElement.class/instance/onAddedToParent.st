children hooks
onAddedToParent
	super onAddedToParent.
	
	self parent addEventHandler: borderListener.
	self onWidthChanged: self parent border width