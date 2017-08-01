selection
intersect: aChildElement in: aSelectionBounds ifNone: aNoneBlock
	"Return selection intersection bounds of a given element and provided
	selection bounds in local child cordinates if intersection exists
	or evaluate a none block otherwise.
	Note: you should override me to modify selection area detection, for example
	for the case of text selection intersection is not just plain intersection"
	<return: #BlBounds>

	^ aSelectionBounds
		intersect: aChildElement boundsInLocal
		ifNone: aNoneBlock