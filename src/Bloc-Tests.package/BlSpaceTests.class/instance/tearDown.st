initialization
tearDown
	super tearDown.

	host destroyHostSpaceFor: space.
	space host: nil.
	host := nil.
	space := nil