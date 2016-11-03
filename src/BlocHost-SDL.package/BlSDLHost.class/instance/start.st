api
start
	((SDL2 wasInit: SDL_INIT_VIDEO) =  0)
		ifTrue: [ SDL2 initVideo ]