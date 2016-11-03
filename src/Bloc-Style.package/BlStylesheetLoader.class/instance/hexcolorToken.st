grammar value
hexcolorToken
	^ super hexcolorToken
		==>
			[ :nodes | BlColorValue value: (self colorClass fromHexString: nodes inputValue allButFirst) ]