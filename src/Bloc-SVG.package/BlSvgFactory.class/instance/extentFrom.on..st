groups
extentFrom: node on: aBlElement
	|width height|
	width:= aBlElement width.
	height:= aBlElement height.
	node attributeAt:'width' ifPresent:[width := (node attributeAt:'width') asNumber].
	node attributeAt:'height' ifPresent:[height := (node attributeAt:'height') asNumber].
	aBlElement extent: width@height