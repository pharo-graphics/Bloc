change report
clearDirtyAreasFor: aStage
	aStage dirtyAreas removeAll.
	aStage dirtyAreas add: (0@0 extent: aStage contentExtent)
	