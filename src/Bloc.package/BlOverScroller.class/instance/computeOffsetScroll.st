scrolling
computeOffsetScroll

	self time synchronized: [
		scrollerX update
			ifFalse: [ scrollerX finish ].
		scrollerY update
			ifFalse: [ scrollerY finish ] ]