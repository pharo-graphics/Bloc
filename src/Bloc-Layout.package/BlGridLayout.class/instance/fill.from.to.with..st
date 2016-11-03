private utilities
fill: anArray from: fromIndex to: toIndex with: value
	
	anArray
		atAll: ((fromIndex min: anArray size) to: (toIndex min: anArray size))
		put: value