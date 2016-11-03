as yet unclassified
doRender: aSpace
	"Redraw a dirtyArea of the node and on the given athens canvas"

	| currentDirtyRect |
	 self dirtyAreas ifEmpty:[self clearDirtyAreasFor: aSpace.  ^ self].
	"currentDirtyRect := self dirtyAreas reduce:[:a :b| a quickMerge:b]."
	currentDirtyRect := (0@0 extent: aSpace contentExtent).
	self clearDirtyAreasFor: aSpace.
	self lock critical: [ 
			(self surfaceForSpace: aSpace)
				drawDuring: [ :anAthensCanvas | 
					aSpace fullDrawOnAthensCanvas: anAthensCanvas  ] ]