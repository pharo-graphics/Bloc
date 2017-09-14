gradients & patterns
linearGradientFrom: node
	|aBlGradientPaint|
	aBlGradientPaint := BlLinearGradientPaint new
		start: (self linearGradientStartingPointFrom: node);
		end: (self linearGradientEndingPointFrom: node);
		yourself.
	
	self gradientFrom: node on: aBlGradientPaint