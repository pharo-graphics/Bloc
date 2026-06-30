Extension { #name : #OSSDL3BackendWindow }

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> canvasExtent [

	^ sdlWindow pixelExtent
]

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> center [

	sdlWindow centerBoth
]

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> fullscreen [

	^ sdlWindow isFullscreen
]

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> maximized [

	^ sdlWindow isMaximized
]

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> minimized [

	^ sdlWindow isMinimized
]

{ #category : #'*BlocHost-OSWindow-SDL3' }
OSSDL3BackendWindow >> newBlocRenderer [

	^ renderer := BlOSSDL3Renderer defaultClass for: self
]
