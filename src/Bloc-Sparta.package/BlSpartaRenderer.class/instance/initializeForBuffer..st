initialization
initializeForBuffer: aBufferSurface
	"Initalize sparta canvas to be used with a pixel buffer surface"
	| scaleFactor |

	windowExtent := aBufferSurface windowExtent.
	canvasExtent := aBufferSurface canvasExtent.

	scaleFactor := aBufferSurface scaleFactor.
	spartaCanvas := self class defaultCanvasBuilder forBufferOn: aBufferSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		apply