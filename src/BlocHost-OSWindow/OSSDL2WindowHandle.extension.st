Extension { #name : #OSSDL2WindowHandle }

{ #category : #'*BlocHost-OSWindow' }
OSSDL2WindowHandle >> fullscreen [
	^ handle getFlags anyMask: SDL_WINDOW_FULLSCREEN
]

{ #category : #'*BlocHost-OSWindow' }
OSSDL2WindowHandle >> maximized [
	^ handle getFlags anyMask: SDL_WINDOW_MAXIMIZED
]

{ #category : #'*BlocHost-OSWindow' }
OSSDL2WindowHandle >> minimized [
	^ handle getFlags anyMask: SDL_WINDOW_MINIMIZED
]

{ #category : #'*BlocHost-OSWindow' }
OSSDL2WindowHandle >> newBlocRenderer [
	^ renderer := BlOSWindowSDL2Renderer for: self
]
