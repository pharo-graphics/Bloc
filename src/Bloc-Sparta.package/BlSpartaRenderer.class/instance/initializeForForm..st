initialization
initializeForForm: aFormSurface
	"Initalize sparta canvas to be used with a form surface"
	| scaleFactor canvasExtent |

	windowExtent := aFormSurface windowExtent.
	canvasExtent := aFormSurface canvasExtent.

	scaleFactor := (canvasExtent / windowExtent) asFloatPoint.
	spartaCanvas := self class defaultCanvasBuilder forFormOn: aFormSurface.
	self
		assert: [ spartaCanvas isValid ]
		description: [ 'Failed to create sparta canvas' ].

	spartaCanvas transform
		scaleBy: scaleFactor;
		apply