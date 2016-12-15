children dispatching
managedChildrenChanged
	self children managedArrayChanged.
	self requestLayout.
	self changed