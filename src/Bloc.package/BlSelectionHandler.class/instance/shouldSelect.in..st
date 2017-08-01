selection
shouldSelect: aChildElement in: aSelectionBounds
	"Return true if a child element should be selected taking into account
	provided selection area bounds given int local coordinates of a child element"
	<return: #Boolean>
	
	^ (self
		intersect: aChildElement
		in: aSelectionBounds
		ifNone: [ nil ]) isNotNil