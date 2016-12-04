initialization
initialize
	super initialize.
	
	position := BlInfiniteElement noPosition.
	previousPosition := BlInfiniteElement noPosition.
	preLayoutPosition := BlInfiniteElement noPosition.
	itemId := BlInfiniteElement noId.
	flags := BlInfiniteElementHolderFlags new.
	itemType := BlInfiniteItemType invalid.
	isInChangeScrap := false.
	recyclableCount := 0