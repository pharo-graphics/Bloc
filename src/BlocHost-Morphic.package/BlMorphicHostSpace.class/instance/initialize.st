initialization
initialize
	super initialize.

	mutex := Mutex new.
	eventFetcher := BlHostEventFetcher new