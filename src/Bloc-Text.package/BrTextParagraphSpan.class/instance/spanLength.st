accessing - span
spanLength
	<return: #Number>

	^ (spanStart isZero and: [ spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ spanEnd - spanStart + 1 ]