initialization
initializeBufferOn: aBufferSurface
	"Initalize sparta canvas to be used with a form surface"
	| scaleFactor canvasExtent |

	windowExtent := aBufferSurface windowExtent.
	canvasExtent := aBufferSurface canvasExtent.

	scaleFactor := (canvasExtent / windowExtent) asFloatPoint.
	spartaCanvas := self class defaultCanvasBuilder forBufferOn: aBufferSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		apply