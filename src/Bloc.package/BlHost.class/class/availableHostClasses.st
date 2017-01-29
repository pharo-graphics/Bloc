driver selection
availableHostClasses
	"Return all available bloc host classes sorted by their priority"
	<return: #Collection>

	^ (self allSubclasses select: [ :aHostClass | aHostClass isSupported ])
		sort: [ :a :b | a priority < b priority ]