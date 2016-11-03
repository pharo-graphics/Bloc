as yet unclassified
asAthensPaintOn: anAthensCanvas
	 ^ paintCache ifNil: [paintCache := (anAthensCanvas surface createSolidColorPaint: color) ].
	