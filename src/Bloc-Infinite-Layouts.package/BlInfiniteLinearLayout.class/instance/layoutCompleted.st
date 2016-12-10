layout
layoutCompleted
	super layoutCompleted.

	pendingScrollPosition := BlInfiniteElement noPosition.
	pendingScrollPositionOffset := self class invalidOffset.
	anchorInfo reset