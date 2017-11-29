private
normalizeDirection: aVector
	<return: #BlVector>

	^ aVector length isZero
		ifTrue: [ BlVector x: 1 y: 0 ]
		ifFalse: [ aVector normalized ]