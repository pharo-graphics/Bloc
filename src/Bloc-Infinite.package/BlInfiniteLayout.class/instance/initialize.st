initialization
initialize
	super initialize.
	
	requestedSimpleAnimations := false.
	autoMeasure := self defaultAutoMeasure.

	"InfiniteLayout has its own more strict measurement cache to avoid re-measuring a child
	if the space that will be given to it is already larger than what it has measured before"
	measurementCacheEnabled := true.
	
	"disable until not implemented"
	itemPrefetchEnabled := false