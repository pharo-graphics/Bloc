Extension { #name : #OSSDL2WindowHandle }

{ #category : #'*BlocHost-OSWindow' }
OSSDL2WindowHandle >> newBlocRenderer [
	^ renderer := BlOSWindowSDL2Renderer for: self
]
