accessing
availableCanvasBuilderClasses
	"Return all available sparta canvas builder classes sorted by their priority"
	<return: #Collection>
	
	^ ((BlSpartaCanvasBuilder allSubclasses select: [ :aBuilderClass | aBuilderClass isSupported ])
		select: [ :aBuilderClass | 
			BlHostRendererSurface allSurfaces anySatisfy: [ :aSurface |
				(aSurface supportedBy: aBuilderClass) and: [ aSurface supportedBy: BlUniverse default host ] ] ])
		sort: [ :a :b | a priority < b priority ]