initialization
defaultBackground
	^ BlRadialGradientPaint new
		stops: { 
			0 -> Color yellow .
			1 -> Color orange };
		radius: 200;
		center: 100@100