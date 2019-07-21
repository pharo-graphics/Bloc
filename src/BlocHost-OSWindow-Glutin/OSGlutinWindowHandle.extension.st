Extension { #name : #OSGlutinWindowHandle }

{ #category : #'*BlocHost-OSWindow-Glutin' }
OSGlutinWindowHandle >> newBlocRenderer [
	^ renderer := BlGlutinRenderer for: self
	"^ renderer := BlOSWindowGlutinWebrenderRenderer for: self"
]
