accessing
pickCanvasBuilderClass
	"Find a default sparta canvas builder among all available.
	Return a special null one if there are no available builders"
	<return: #'BlSpartaCanvasBuilder class'>

	^ self availableCanvasBuilderClasses
		"There are no availbale builders, return a null one"
		ifEmpty: [ self shouldBeImplemented ]
		ifNotEmpty: [ :theBuilderClasses | theBuilderClasses first ]