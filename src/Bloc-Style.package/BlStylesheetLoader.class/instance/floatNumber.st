grammar value
floatNumber
	^ super floatNumber  ==> [ :nodes | Number readFrom: nodes ]