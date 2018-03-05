instance creation
onBindHolder: anElementHolder at: aPosition
	anElementHolder
		color: (colors at: aPosition);
		constraintsDo: constraintsBlock