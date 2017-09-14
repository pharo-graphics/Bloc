accessing
pathData: aCollection
	| r |
	pathData := aCollection.
	r := BlSvgPathExtentResolver new computeExtentFor: pathData.
	extent := r extent.
	position := r minPoint.