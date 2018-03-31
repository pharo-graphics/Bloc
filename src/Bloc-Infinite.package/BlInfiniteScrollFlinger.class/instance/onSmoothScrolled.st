hooks
onSmoothScrolled
	self scrollable hasItemDecorations
		ifTrue: [ self scrollable invalidate ]