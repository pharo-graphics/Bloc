driver selection
defaultHostClass
	"Find a default bloc host among all available.
	Return a special null one if there are no available hosts"
	<return: #'BlHost class'>

	^ self availableHostClasses
		"There are no availbale hosts, return a null one"
		ifEmpty: [ BlNullHost ]
		ifNotEmpty: [ :theHostClasses | theHostClasses first ]