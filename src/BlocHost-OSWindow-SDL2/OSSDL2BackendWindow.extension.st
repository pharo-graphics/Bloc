Extension { #name : #OSSDL2BackendWindow }

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
