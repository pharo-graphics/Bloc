initialization
initializeWindowHandle: aWindowHandle

	self window: aWindowHandle.
	renderer := window handle createRenderer: -1 flags: SDL_RENDERER_ACCELERATED