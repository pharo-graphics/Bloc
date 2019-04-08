Extension { #name : #OSSDL2WindowHandle }

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2WindowHandle >> fullscreen [
	<return: #Boolean>

	^ handle getFlags anyMask: SDL_WINDOW_FULLSCREEN
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2WindowHandle >> maximized [
	<return: #Boolean>

	^ handle getFlags anyMask: SDL_WINDOW_MAXIMIZED
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2WindowHandle >> minimized [
	<return: #Boolean>

	^ handle getFlags anyMask: SDL_WINDOW_MINIMIZED
]

{ #category : #'*BlocHost-OSWindow-SDL2' }
OSSDL2WindowHandle >> newBlocRenderer [
	^ renderer := BlOSWindowSDL2Renderer for: self
]
