private - invalidate
reset

	flags removeAll.
	position := BlInfiniteElement noPosition.
	previousPosition := BlInfiniteElement noPosition.
	itemId := BlInfiniteElement noId.
	preLayoutPosition := BlInfiniteElement noPosition.
	recyclableCount := 0.
	shadowedHolder := nil.
	shadowingHolder := nil.
	self clearPayload