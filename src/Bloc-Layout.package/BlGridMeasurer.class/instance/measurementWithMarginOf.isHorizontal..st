measure
measurementWithMarginOf: aChildElement isHorizontal: isHorizontal
	<return: #Number>

	aChildElement visibility shouldLayout
		ifFalse: [ ^ 0 ].

	^ (self measurementOf: aChildElement isHorizontal: isHorizontal) + (self totalMarginOf: aChildElement isHorizontal: isHorizontal)