initialization
initialize
	super initialize.
	
	isHorizontal := false.
	hasWeights := false.
	
	groupBoundsValid := false.
	forwardLinksValid := false.
	backwardLinksValid := false.
	leadingMarginsValid := false.
	trailingMarginsValid := false.
	arcsValid := false.
	hasWeightsValid := false.
	locationsValid := false.
	
	orderPreserved := self defaultOrderPreserved.
	maxIndex := UNDEFINED.
	definedCount := UNDEFINED.
	parentMin := BlGridMutableInteger value: 0.
	parentMax := BlGridMutableInteger new.