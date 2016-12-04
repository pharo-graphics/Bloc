children - add/remove hooks
childAdded: anElement
	
	(self elementHolderOf: anElement)
		ifNotNil: [ :holder |
			"Notify data source that child was added"
			self dataSource onElementAdded: holder ]