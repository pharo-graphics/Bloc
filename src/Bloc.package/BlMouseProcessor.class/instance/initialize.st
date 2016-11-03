initialize-release
initialize
	super initialize.
	lastEnteredTargets := OrderedCollection new.
	isMouseStillDown := 0.
	dragStartMask := 0.
	dndInProgress := false.