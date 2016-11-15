initialization
initialize
	super initialize.
	
	position := BlInfiniteElement noPosition.
	preLayoutPosition := BlInfiniteElement noPosition.
	flags := Dictionary new.
	itemType := BlInfiniteItemType invalid