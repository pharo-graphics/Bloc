groups
positionFrom:node on:aBlElement
	|x y|
	x:= y:= 0.
	node attributeAt:'x' ifPresent:[x := (node attributeAt:'x') asNumber].
	node attributeAt:'y' ifPresent:[y := (node attributeAt:'y') asNumber].
	aBlElement position: x@y