adding
pushSpan: aParagraphSpan

	aParagraphSpan
		textRun: self textRun
		start: self textRunStart
		end: self textRunEnd.

	aParagraphSpan
		span: self span
		start: self spanStart
		end: self spanEnd.
		
	aParagraphSpan
		text: self text
		from: self textStart
		to: self textEnd.
	
	spans add: aParagraphSpan.
	accumulatedWidth := accumulatedWidth + aParagraphSpan width.
	
	"after pushing a new span, we should also move glyphs start index"
	textRunStart := textRunEnd + 1.
	
	"and move text position"
	self pushPosition: self spanLength - 1