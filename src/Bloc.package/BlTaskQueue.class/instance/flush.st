api - enqueue
flush
	^ lock critical: [
		| theTasks |
		theTasks := tasks.
		tasks := #().
		theTasks ]