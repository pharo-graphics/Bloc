mathematical functions
multiplyOn: aBlMatrix in: aBlElement
	| anOriginPoint aVector |

	anOriginPoint := self origin originIn: aBlElement.
	aVector := anOriginPoint asBlocVector.
	
	aBlMatrix translateBy: aVector negated.
	self multiplyOn: aBlMatrix.
	aBlMatrix translateBy: aVector