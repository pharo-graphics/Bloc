interpolation
interpolate: aNumber
	"f(x) = 1 - (1 - x)^n, where n = 2 * factor"
	
	^ self factor = 1
		"Special case, can be computed faster"
		ifTrue: [ 1.0 - ((1.0 - aNumber) * (1.0 - aNumber)) ]
		ifFalse: [ 1.0 - ((1.0 - aNumber) raisedTo: 2 * factor) ]