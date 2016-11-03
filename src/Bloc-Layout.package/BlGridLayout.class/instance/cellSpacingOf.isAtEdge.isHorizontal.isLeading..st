computation
cellSpacingOf: aChildElement isAtEdge: isAtEdge isHorizontal: isHorizontal isLeading: isLeading
	"Return cell spacing around aChildElement at the side defined by isAtEdge, isHorizontal and isLeading.
	isAtEdge is a boolean whose value is true if cell is located on the grid's edge, meaning that it
		is first (index = 1) or last (index = N + 1) in the group of cell (in the row or column).
	isHorizontal is a boolean whose value is true if spacing needs to be returned for horizontal
		side which is left or right.
	isLeading is a boolean value whose value is true if desired cell side is the first along orientation
		define by isHorizontal, e.g. if isHorizontal is true and isLeading is true than it is left side,
		if isHorizontal is true and isLeading is false side should be right. The same applies for
		vertical orientation, top side if isLeading is true and bottom if false.
	Default implementation uses cell spacing value defined in GridLayout and makes sure that spacing
	between cells is equal to spacing between cell and grid's border.
	Override me if you want to have custom cell spacing"
	<return: #Number>

	^ isAtEdge
		ifTrue: [ self cellSpacing ]
		ifFalse: [ self cellSpacing / 2.0 ]