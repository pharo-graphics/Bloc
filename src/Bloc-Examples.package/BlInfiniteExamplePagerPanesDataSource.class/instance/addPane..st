accessing
addPane: aPagerPane

	panes add: aPagerPane.
	self notifyItemsInserted: (panes size to: panes size)