private - rounding
truncated: aNumber
	"Truncate a given number according to my current rounding precision"
	<return: #Number>

	^ self shouldRound
		ifTrue: [ aNumber truncated ]
		ifFalse: [ aNumber ]