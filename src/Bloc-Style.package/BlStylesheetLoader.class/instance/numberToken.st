grammar value
numberToken
	^ super numberToken ==> [ :nodes | BlNumberValue value value: nodes parsedValue ]