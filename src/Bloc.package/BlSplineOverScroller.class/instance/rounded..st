private - rounding
rounded: aNumber
	"Round a given number according to my current rounding precision"
	<return: #Number>
	
	^ self shouldRound
		ifTrue: [ aNumber rounded ]
		ifFalse: [ aNumber ]