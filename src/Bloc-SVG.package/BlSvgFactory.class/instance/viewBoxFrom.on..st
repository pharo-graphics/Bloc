groups
viewBoxFrom: node on: aBlElement
	|array|
	node attributeAt:'viewBox' ifPresent:[
		array := ((node attributeAt:'viewBox') substrings:{Character space. $,}) collect: [ :valueString | valueString asNumber ].
		
		aBlElement forceLayout.
		aBlElement translateBy: array first negated @ (array second negated).
		aBlElement scaleX: (array third)/(aBlElement width) Y: (array last)/(aBlElement height).
	]