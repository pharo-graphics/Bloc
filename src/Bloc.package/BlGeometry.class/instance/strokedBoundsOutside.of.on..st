visual bounds
strokedBoundsOutside: aBlBounds of: anElement on: aCanvas
	| spartaPath strokeOptions strokedBounds |

	spartaPath := anElement geometry pathOnSpartaCanvas: aCanvas.
	strokeOptions := aCanvas stroke
		in: [ :aPainter | anElement border style applyOn: aPainter ];
		width: ((anElement border width * 2.0) max: 1);
		strokeOptions.

	strokedBounds := spartaPath strokedBoundsOn: aCanvas with: strokeOptions.
	^ aBlBounds rectangle: strokedBounds