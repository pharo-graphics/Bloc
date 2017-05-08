initialization
initializeFormOn: aFormSurface
	"Initalize sparta canvas to be used with a form surface"
	| scaleFactor canvasExtent |

	windowExtent := aFormSurface windowExtent.
	canvasExtent := aFormSurface canvasExtent.

	scaleFactor := (canvasExtent / windowExtent) asFloatPoint.
	spartaCanvas := self class defaultCanvasBuilder forDataOn: aFormSurface.

	spartaCanvas transform
		scaleBy: scaleFactor;
		apply