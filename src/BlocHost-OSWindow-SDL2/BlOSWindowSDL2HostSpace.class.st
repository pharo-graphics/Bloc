Class {
	#name : 'BlOSWindowSDL2HostSpace',
	#superclass : 'BlOSWindowHostSpace',
	#category : 'BlocHost-OSWindow-SDL2',
	#package : 'BlocHost-OSWindow-SDL2'
}

{ #category : 'initialization' }
BlOSWindowSDL2HostSpace >> createBufferSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>

	^ BlOSWindowSDL2BufferSurfaceRenderer new
		  window: window;
		  yourself
]

{ #category : 'initialization' }
BlOSWindowSDL2HostSpace >> newBlHostRendererSurface [

	^ BlHostRendererBufferSurface newForHostSpace: self
]
