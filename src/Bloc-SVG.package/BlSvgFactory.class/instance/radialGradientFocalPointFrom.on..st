gradients & patterns
radialGradientFocalPointFrom: node on: aBlRadialGradientPaint
	|fx fy|
	fx := aBlRadialGradientPaint center x.
	fy := aBlRadialGradientPaint center y.
	node attributeAt:'fx' ifPresent:[fx := (node attributeAt:'fx') asNumber].
	node attributeAt:'fy' ifPresent:[fy := (node attributeAt:'fy') asNumber].
	aBlRadialGradientPaint focalPoint:  fx@fy.