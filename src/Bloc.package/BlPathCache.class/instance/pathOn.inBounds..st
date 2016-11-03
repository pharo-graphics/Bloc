accessing
pathOn: aCanvas inBounds: aBounds
	^ aCanvas
		createPath: [ :aBuilder | self owner geometry buildPathOn: aBuilder within:  aBounds ]