api - running
run
	| theTasks |
	
	lock critical: [
		"We store reference to tasks Array because it is possible
		that a random task is removed while enumerating a collection"
		theTasks := tasks.
		tasks := #() ].

	"since we have an immutble reference to original array, there is need to execute task within a lock"
	theTasks do: [ :aTask | aTask run ]