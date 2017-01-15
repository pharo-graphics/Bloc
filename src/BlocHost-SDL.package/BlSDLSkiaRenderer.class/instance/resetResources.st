updating resources
resetResources
	| windowExtent |
		
	glContext := SDL2 glCreateContext: sdlSpace sdlWindow handle.

	windowExtent := sdlSpace windowExtent.
	drawableExtent := sdlSpace drawableExtent.

	SDL2 glClearColorR: 1 g: 1 b: 1 a: 1.
	SDL2 glSetSwapInterval: 1.
	
	scaleFactor := (drawableExtent / windowExtent) asFloatPoint.

	skiaCanvas := SkiaCanvas
		extent: windowExtent
		renderExtent: drawableExtent.
	
	skiaCanvas transform
		scaleBy: scaleFactor;
		apply