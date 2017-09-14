polyline & polygon
pointsFrom: node
	node attributeAt: 'points' ifPresent: [ ^ ((node attributeAt: 'points') substrings: ' ') collect: [ :XAndY | (XAndY copyUpTo: $,) asNumber @ (XAndY copyAfter: $,) asNumber ] ]