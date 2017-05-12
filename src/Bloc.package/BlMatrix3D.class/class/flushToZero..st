instance creation
flushToZero: aFloat
	^ (aFloat closeTo: 0.0)
		ifTrue: [ 0.0 ]
		ifFalse: [ aFloat ]