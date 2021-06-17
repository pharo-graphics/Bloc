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
