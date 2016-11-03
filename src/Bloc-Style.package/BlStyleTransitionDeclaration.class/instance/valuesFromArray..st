importing
valuesFromArray: anArray
	self duration: (anArray at: 1 ifAbsent: [ ^ self duration ]) value.
	self timingFunction: (anArray at: 2 ifAbsent: [ ^ self timingFunction ]) value.
	self delay: (anArray at: 3 ifAbsent: [ ^ self delay ]) value