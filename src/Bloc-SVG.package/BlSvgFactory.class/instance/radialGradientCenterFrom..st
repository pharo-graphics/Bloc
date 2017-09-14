gradients & patterns
radialGradientCenterFrom: node
	|cx cy|
	cx:= cy:= 50.
	node attributeAt:'cx' ifPresent:[cx := (node attributeAt:'cx') asNumber].
	node attributeAt:'cy' ifPresent:[cy := (node attributeAt:'cy') asNumber].
	^cx@cy