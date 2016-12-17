layout
layoutCompleted
	super layoutCompleted.

	pendingScrollPosition := NoPosition.
	pendingScrollPositionOffset := self class invalidOffset.
	anchorInfo reset