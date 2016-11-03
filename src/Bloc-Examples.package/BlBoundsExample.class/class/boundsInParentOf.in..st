as yet unclassified
boundsInParentOf: el in: aRoot
	^ self
		newLineGroupFor: el boundsInParent
		in: aRoot
		color: Color black
		width: 6