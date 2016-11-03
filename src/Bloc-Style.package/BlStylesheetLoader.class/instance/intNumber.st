grammar value
intNumber
	^ super intNumber  ==> [ :nodes | Number readFrom: nodes ]