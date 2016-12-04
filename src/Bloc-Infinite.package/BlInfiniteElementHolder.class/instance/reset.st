private - invalidate
reset

	flags clear.
	position := BlInfiniteElement noPosition.
	previousPosition := BlInfiniteElement noPosition.
	itemId := BlInfiniteElement noId.
	preLayoutPosition := BlInfiniteElement noPosition.
	recyclableCount := 0.
	shadowedHolder := nil.
	shadowingHolder := nil.
	self clearPayload