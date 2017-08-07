text run - accessing
textRun: aTextRun
	"Set a text run (a collection of glyphs) that should be measured"
	
	textRun := aTextRun.
	textRunStart := aTextRun isNotEmpty asBit.
	textRunSize := textRun size.
	textRunEnd := 0