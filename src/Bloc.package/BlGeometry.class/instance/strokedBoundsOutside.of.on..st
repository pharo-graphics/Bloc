visual bounds
strokedBoundsOutside: aBlBounds of: anElement on: aCanvas
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement pathCache geomPathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border applyOn: aPainter ];
		width: anElement border width * 2.0;
		strokeOptions.

	strokedBounds := spartaPath strokedBounds: strokeOptions.
	^ aBlBounds rectangle: strokedBounds