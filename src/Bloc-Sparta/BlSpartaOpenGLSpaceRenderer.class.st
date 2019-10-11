Class {
	#name : #BlSpartaOpenGLSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaOpenGLSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (self class pickCanvasForSurface: aSurface) forOpenGLOn: aSurface.
	self
		initializeWithCanvas: aSpartaCanvas
		surface: aSurface
]
