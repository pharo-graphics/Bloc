attach points
hideAttachPoints
	self attachPoints do: [ :anAttachPoint |
		anAttachPoint visibility: BlVisibility hidden ]