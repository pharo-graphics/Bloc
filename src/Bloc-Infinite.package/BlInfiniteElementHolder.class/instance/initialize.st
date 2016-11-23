initialization
initialize
	super initialize.
	
	position := BlInfiniteElement noPosition.
	previousPosition := BlInfiniteElement noPosition.
	preLayoutPosition := BlInfiniteElement noPosition.
	itemId := BlInfiniteElement noId.
	flags := Dictionary new.
	itemType := BlInfiniteItemType invalid.
	isInChangeScrap := false.
	recyclableCount := 0