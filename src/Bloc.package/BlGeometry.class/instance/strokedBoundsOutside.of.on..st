visual bounds
strokedBoundsOutside: aBlBounds of: anElement on: aCanvas
	| spartaPath strokeOptions strokedBounds |

	spartaPath := self pathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		width: ((anElement border width * 2.0) max: 1);
		strokeOptions.

	strokedBounds := boundsCache
		boundsFor: spartaPath
		stroked: strokeOptions
		on: aCanvas
		within: anElement outskirts.	
	
	^ aBlBounds rectangle: strokedBounds