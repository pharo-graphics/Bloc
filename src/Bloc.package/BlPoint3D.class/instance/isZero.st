testing
isZero
	"Return true if all my components are zeros, false otherwise"
	<return: #Boolean>
	
	^ x isZero and: [ y isZero and: [ z isZero ] ]