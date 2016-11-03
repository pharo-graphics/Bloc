accessing
fill: aFill
	fill := aFill asBlPaint. 
	self updateTextModelFill.
	self invalidate.