computing margins
trailingMargins
	
	trailingMargins
		ifNil: [ trailingMargins := Array new: (self count + 1) withAll: 0 ].
		
	trailingMarginsValid ifFalse: [ 
		self computeMargins: false.
		trailingMarginsValid := true ].
	
	^ trailingMargins