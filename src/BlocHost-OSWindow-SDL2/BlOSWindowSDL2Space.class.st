Class {
	#name : #BlOSWindowSDL2Space,
	#superclass : #BlOSWindowSpace,
	#category : #'BlocHost-OSWindow-SDL2'
}

{ #category : #initialization }
BlOSWindowSDL2Space >> createBufferSurfaceRenderer [
	<return: #BlHostSurfaceRenderer>
	
	^ BlOSWindowSDL2BufferSurfaceRenderer new window: window
]
