gradients & patterns
gradientFrom: node on: aBlGradientPaint
	|stopCollection|
	
	stopCollection := OrderedCollection new.
	node nodesDo: [ :child | | keyAndValue |
			keyAndValue := child translatedBy: self withParent: aBlGradientPaint.
			keyAndValue ifNotNil: [ stopCollection add: keyAndValue ] ].
	aBlGradientPaint stops: stopCollection.
		
	self idHandlingFrom: node attributes on: aBlGradientPaint.