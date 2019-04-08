Extension { #name : #OSGlutinWindowHandle }

{ #category : #'*BlocHost-OSWindow-Glutin' }
OSGlutinWindowHandle >> newBlocRenderer [
	^ renderer := BlOSWindowGlutinRenderer for: self
]
