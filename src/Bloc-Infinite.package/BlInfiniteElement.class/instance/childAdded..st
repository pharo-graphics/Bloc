children add/remove hooks
childAdded: anElement
	super childAdded: anElement.
	
	(self childHolderOf: anElement)
		ifNotNil: [ :holder |
			"Notify data source that child was added"
			self dataSource onChildAdded: holder ]