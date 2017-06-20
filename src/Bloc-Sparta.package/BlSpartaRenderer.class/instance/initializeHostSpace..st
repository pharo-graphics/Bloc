initialization
initializeHostSpace: aBlHostSpace
	| availableSurfaces |
	
	availableSurfaces := (BlHostRendererSurface allSurfaces select: [ :aSurfaceClass | 
		(aSurfaceClass supportedBy: self class defaultCanvasBuilder class)
			and: [ aSurfaceClass supportedBy: aBlHostSpace ] ])
				sort: [ :a :b | a priority < b priority ].
		
	availableSurfaces ifEmpty: [ 
		^ self error: aBlHostSpace asString, ' does not support any available surfaces' ].
	
	surface := availableSurfaces first new.
	surface initializeOn: aBlHostSpace