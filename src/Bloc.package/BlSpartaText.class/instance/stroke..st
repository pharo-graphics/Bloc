accessing
stroke: aStroke
	stroke := aStroke asBlBorderStroke. 
	self updateTextModelStroke.
	self invalidate.