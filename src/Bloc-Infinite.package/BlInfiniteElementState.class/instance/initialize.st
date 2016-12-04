initialization
initialize
	super initialize.
	
	targetPosition := BlInfiniteElement noPosition.

	layoutStep := self defaultLayoutStep.

	data := Dictionary new.
	
	itemCount := 0.
	previousLayoutItemCount := 0.
	deletedInvisibleItemCountSincePreviousLayout := 0.
	
	structureChanged := false.
	inPreLayout := false.
	runSimpleAnimations := false.
	runPredictiveAnimations := false.
	trackOldChangeHolders := false.
	isMeasuring := false.
	
	focusedItemPosition := BlInfiniteElement noPosition.
	focusedItemId := BlInfiniteElement noId.
	focusedSubChild := nil