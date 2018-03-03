adding
initializeSpan: aParagraphSpan
	"Initialize a given paragraph span with a corresponding text, text run
	and their start and end indices"

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