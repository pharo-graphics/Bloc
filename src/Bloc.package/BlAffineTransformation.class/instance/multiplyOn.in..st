mathematical functions
multiplyOn: aBlMatrix in: aBlElement
	| anOriginPoint |

	anOriginPoint := self origin originIn: aBlElement.

	aBlMatrix translateBy: anOriginPoint.
	self multiplyOn: aBlMatrix.
	aBlMatrix translateBy: anOriginPoint negated