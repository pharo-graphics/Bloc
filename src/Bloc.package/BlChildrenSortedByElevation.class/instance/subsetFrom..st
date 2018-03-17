initialization
subsetFrom: aBlChildren
	^ aBlChildren asArray sorted: [ :a :b | (a elevation relatedTo: 0) <= (b elevation relatedTo: 0) ]