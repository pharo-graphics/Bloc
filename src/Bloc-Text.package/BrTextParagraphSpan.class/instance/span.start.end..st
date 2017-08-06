initialization
span: aBrSpan start: aSpanStart end: aSpanEnd
	"Assign an attributed text span with corresponding start and end indices which I measure"
	
	span := aBrSpan.
	spanStart := aSpanStart.
	spanEnd := aSpanEnd.
	length := aSpanEnd  - aSpanStart + 1.
	
	self assertSpan