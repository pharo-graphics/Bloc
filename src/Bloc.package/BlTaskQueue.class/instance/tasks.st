api - accessing
tasks
	"Return a new collection instance holding all my tasks"
	| theTasks |
		
	lock critical: [
		"We store reference to tasks Array because it is possible
		that a random task is removed while enumerating a collection"
		theTasks := tasks ].
	
	^ theTasks