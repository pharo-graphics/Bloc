as yet unclassified
render: aStage
	self dirtyAreas: aStage dirtyAreas.
	self renderNeeded
	   ifTrue: [
			self doRender:aStage ]