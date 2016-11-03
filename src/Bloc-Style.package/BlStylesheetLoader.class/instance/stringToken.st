grammar value
stringToken
	^ super stringToken ==> [ :nodes | BlStringValue value value: nodes parsedValue ]