gradients & patterns
radialGradientFrom: node
	|aBlSVGGradientPaint|
	aBlSVGGradientPaint := BlRadialGradientPaint new
		center: (self radialGradientCenterFrom: node);
		radius: (self radialGradientRadiusFrom: node);
		yourself.
	self radialGradientFocalPointFrom: node on: aBlSVGGradientPaint. 
	
	self gradientFrom: node on: aBlSVGGradientPaint