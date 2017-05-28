initialization
initialize
	super initialize.

	eventQueue := WaitfreeQueue new.
	mutex := Mutex new.
	mirrowWindows := OrderedCollection new