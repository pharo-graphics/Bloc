testing
isRunning
	"Return true if host in already running"
	<return: #Boolean>

	^ (SDL2 wasInit: SDL_INIT_VIDEO) > 0