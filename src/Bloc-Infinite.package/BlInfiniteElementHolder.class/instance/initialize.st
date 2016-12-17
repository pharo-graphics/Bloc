initialization
initialize
	super initialize.
	
	position := NoPosition.
	previousPosition := NoPosition.
	preLayoutPosition := NoPosition.
	itemId := NoId.
	flags := BlInfiniteElementHolderFlags new.
	itemType := BlInfiniteItemType invalid.
	isInChangeScrap := false.
	recyclableCount := 0.
	payloads := OrderedCollection new