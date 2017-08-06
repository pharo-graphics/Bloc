accessing - text run
textRunStart
	"Return an index of a first measured glyph in a text run that should be rendered"
	<return: #Number>
	self assertTextRun.
	
	^ textRunStart