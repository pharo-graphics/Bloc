change reporting
managedChildrenChanged
	self children managedArrayChanged.
	self requestLayout.
	self changed.

	