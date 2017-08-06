initialization
textRun: aTextRun start: aTextRunStart end: aTextRunEnd
	"Assign a backend specific text run (collection of glyphs) with corresponding
	start and end indices which represents an unstyled piece of text"
	
	textRun := aTextRun.
	textRunStart := aTextRunStart.
	textRunEnd := aTextRunEnd.
	
	self assertTextRun