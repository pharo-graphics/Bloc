hooks
firstSpanAdded
	| aSpan |
	aSpan := spans first.

	left := aSpan left.
	top := aSpan top.
	width := aSpan width.
	height := aSpan height.
	
	ascent := aSpan ascent.
	descent := aSpan descent.

	from := aSpan from.
	to := aSpan to.
	
	aSpan baseline: self baseline