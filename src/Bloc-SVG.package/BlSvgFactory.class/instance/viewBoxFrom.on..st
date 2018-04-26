groups
viewBoxFrom: node on: aBlElement
	|array|
	node attributeAt:'viewBox' ifPresent:[
		array := ((node attributeAt:'viewBox') substrings:{Character space. $,}) collect: [ :valueString | valueString asNumber ].
		
		aBlElement forceLayout.
		aBlElement transformDo: [ :t |
			t translateBy: array first negated @ (array second negated).
			t scaleBy: (array third)/(aBlElement width) @ (array last)/(aBlElement height)] ]