rendering
render: aSpace
	self dirtyAreas: aSpace dirtyAreas.
	self renderNeeded
	   ifTrue: [
			self doRender: aSpace ]