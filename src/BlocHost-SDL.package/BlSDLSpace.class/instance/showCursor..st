private - cursor
showCursor: aBoolean
	SDL2 showCursor: (aBoolean ifTrue: [SDL_ENABLE] ifFalse: [SDL_DISABLE]).
