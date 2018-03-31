initialization
initialize
	super initialize.
	
	targetPosition := NoPosition.

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
	
	focusedItemPosition := NoPosition.
	focusedItemId := NoId.
	focusedSubChild := nil