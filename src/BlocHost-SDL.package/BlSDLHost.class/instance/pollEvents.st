api
pollEvents
	| sdlEvent mappedEvent blocEvent hostSpace|
	sdlEvent := SDL_Event new.
	[ (SDL2 pollEvent: sdlEvent) > 0 ] whileTrue: [ 
	
	mappedEvent := sdlEvent mapped ifNil: [ ^ nil ].
	mappedEvent windowID ifNil: [ ^ self  ].
	
	hostSpace := hostSpaces at: mappedEvent windowID ifAbsent: [ ^ nil ].
	blocEvent := self convertSDLEvent: mappedEvent hostSpace: hostSpace.
	hostSpace ifNotNil:[:hs| hs enqueueEvent: blocEvent].
	BlUniverse default requestNextPulse
	 ]