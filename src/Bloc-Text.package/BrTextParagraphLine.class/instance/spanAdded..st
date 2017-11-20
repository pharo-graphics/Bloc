hooks
spanAdded: aSpan
	
	self
		assert: [ aSpan == spans first ]
		description: [ 'I can only be sent with the first span as argument' ].

	left := aSpan left.
	top := aSpan top.
	width := aSpan width.
	height := aSpan height.
	
	ascent := aSpan ascent.
	descent := aSpan descent.

	from := aSpan from.
	to := aSpan to.
	
	aSpan baseline: self baseline