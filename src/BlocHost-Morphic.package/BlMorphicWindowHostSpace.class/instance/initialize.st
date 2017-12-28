initialization
initialize
	super initialize.

	eventFetcher := BlHostEventFetcher new.
	mutex := Mutex new.
	mirrowWindows := OrderedCollection new