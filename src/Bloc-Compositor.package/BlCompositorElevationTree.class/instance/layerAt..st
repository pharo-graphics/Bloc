accessing
layerAt: anElevation
	"Search for an Elevataion layer and return if found or create a new one otherwise"
	<return: #BlCompositorElevationLayer>
	
	^ self
		at: anElevation
		ifAbsentPut: [	self newLayer elevation: anElevation ]