text run - accessing
textRunLength
	"Return amount of measured glyph processed during last measurement cycle"
	<return: #Object>

	^ self textRunEnd - self textRunStart + 1