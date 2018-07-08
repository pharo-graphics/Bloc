visual bounds
strokedBoundsCentered: aBlBounds of: anElement on: aCanvas
	| spartaPath strokeOptions strokedBounds |

	spartaPath := self pathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		width: (anElement border width max: 1);
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		strokeOptions.

	strokedBounds := boundsCache
		boundsFor: spartaPath
		stroked: strokeOptions
		on: aCanvas
		within: anElement outskirts.

	^ aBlBounds rectangle: strokedBounds