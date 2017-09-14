gradients & patterns
linearGradientEndingPointFrom: node
	|x2 y2|
	x2:= 100.
	y2:= 0.
	node attributeAt:'x2' ifPresent:[x2 := (node attributeAt:'x2') asNumber].
	node attributeAt:'y2' ifPresent:[y2 := (node attributeAt:'y2') asNumber].
	^x2@y2