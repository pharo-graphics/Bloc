geometry
computeOuterHeight: aNumber
	<return: #Number>

	^ (self computeOuterLength: aNumber) / (self computeInnerHeight: aNumber) * (self computeInnerHeight: aNumber)