adding
initializeSpan: aParagraphSpan

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