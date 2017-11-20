adding
pushSpan: aParagraphSpan
	self line addSpan: aParagraphSpan.

	"after pushing a new span, we should also move glyphs start index"
	textRunStart := textRunEnd + 1.

	"and move text position"
	self pushPosition: self spanLength - 1