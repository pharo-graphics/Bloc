Extension { #name : #BlOSWindowSDL2HostSpace }

{ #category : #'*Bloc-Alexandrie' }
BlOSWindowSDL2HostSpace >> newBlHostRendererSurface [

	^ BlHostRendererBufferSurface newForHostSpace: self
]
