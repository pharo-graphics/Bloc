gradients & patterns
linearGradientStartingPointFrom: node
	|x1 y1|
	x1:= y1:= 0.
	node attributeAt:'x1' ifPresent:[x1 := (node attributeAt:'x1') asNumber].
	node attributeAt:'y1' ifPresent:[y1 := (node attributeAt:'y1') asNumber].
	^x1@y1