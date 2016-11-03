*Bloc-Athens
asAthensPaintOn: anAthensCanvas
	 ^ paintCache ifNil: [paintCache := (anAthensCanvas surface createSolidColorPaint: color) ].
	