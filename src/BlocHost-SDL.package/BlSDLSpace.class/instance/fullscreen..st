host space - displaying
fullscreen: aBoolean
	aBoolean ifTrue: [
		sdlWindow fullscreen: SDL_WINDOW_FULLSCREEN_DESKTOP
	] ifFalse: [ 
		sdlWindow fullscreen: 0
	]