Class {
	#name : #BlSpartaFormSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaFormSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (self class pickCanvasForSurface: aSurface) forFormOn: aSurface.
	self
		initializeWithCanvas: aSpartaCanvas
		surface: aSurface
]
