gradients & patterns
radialGradientRadiusFrom: node
	|r|
	r:= 50.
	node attributeAt:'r' ifPresent:[r := (node attributeAt:'r') asNumber].
	^r