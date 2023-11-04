Extension { #name : #OSSDL2BackendWindow }

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> center [
	"Center window on primary display. 
	
	See: https://wiki.libsdl.org/SDL_SetWindowPosition"

	sdl2Window
		setPositionX: SDL_WINDOWPOS_CENTERED
		y: SDL_WINDOWPOS_CENTERED
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> fullscreen [
	<return: #Boolean>

	^ sdl2Window getFlags anyMask: SDL_WINDOW_FULLSCREEN
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> maximized [
	<return: #Boolean>

	^ sdl2Window getFlags anyMask: SDL_WINDOW_MAXIMIZED
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> minimized [
	<return: #Boolean>

	^ sdl2Window getFlags anyMask: SDL_WINDOW_MINIMIZED
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> newBlocRenderer [
	^ renderer := BlOSWindowSDL2Renderer for: self
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2BackendWindow >> stopTextInput [
	"See https://wiki.libsdl.org/SDL_StopTextInput"

	self flag: 'does nothing for now since the current implementation is not thread safe.
	Bloc and Morphic can run in parallel on the same backend window in case a Morphic host is used for Bloc. The consequence is that text input is not activate when switching from a Morph to a BlElement because a stopTextInput can be sent from a Morph ** after ** a startTextInput has been correctly sent from a BlElement.'
	"sdl2Window stopTextInput"
]
