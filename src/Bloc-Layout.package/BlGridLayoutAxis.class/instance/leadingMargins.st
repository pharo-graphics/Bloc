computing margins
leadingMargins
	
	leadingMargins
		ifNil: [ leadingMargins := Array new: (self count + 1) withAll: 0 ].
		
	leadingMarginsValid ifFalse: [ 
		self computeMargins: true.
		leadingMarginsValid := true ].
	
	^ leadingMargins