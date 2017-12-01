geometry
computeOuterLength: aNumber
	<return: #Number>
	| anInnerLength |
	
	anInnerLength := self computeInnerLength: aNumber.
	^ (self arrowLengthFraction * anInnerLength) + anInnerLength