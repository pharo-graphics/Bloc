selection
shouldSelect: aChildElement in: aParentSelectionBounds
	"Return true if a child element should be selected taking into account
	provided selection area bounds given into parent coordinates of a child element"
	
	^ aParentSelectionBounds intersects: aChildElement boundsInParent