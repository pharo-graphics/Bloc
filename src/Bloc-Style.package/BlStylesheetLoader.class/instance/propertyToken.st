grammar declaration
propertyToken
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]