*Bloc-Athens
pathOnAthensCanvas: aCanvas inBounds: aBounds
	^ aCanvas
		createPath: [ :aBuilder | self owner geometry buildAthensPathOn: aBuilder within:  aBounds ]