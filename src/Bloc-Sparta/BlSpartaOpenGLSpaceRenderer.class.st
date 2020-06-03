Class {
	#name : #BlSpartaOpenGLSpaceRenderer,
	#superclass : #BlSpartaHardwareAcceleratedSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #rendering }
BlSpartaOpenGLSpaceRenderer >> damagedAreasOf: aSpace [
	^ { 0@0 extent: aSpace extent }
]

{ #category : #initialization }
BlSpartaOpenGLSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aSurface) forOpenGLOn: aSurface.
	self
		initializeCanvas: aSpartaCanvas
		surface: aSurface
]
