accessing
availableCanvasBuilderClasses
	"Return all available sparta canvas builder classes sorted by their priority"
	<return: #Collection>

	^ (BlSpartaCanvasBuilder allSubclasses select: [ :aBuilderClass | aBuilderClass isSupported ])
		sort: [ :a :b | a priority < b priority ]