initialization
setUp
	super setUp.
	
	space := BlSpace new.
	host := BlMockedHost new.

	space host: host.
	host createHostSpaceFor: space.