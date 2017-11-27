arithmetic
/ aVector
	| vector |
	vector := aVector asBlocVector.

	^ self class
		x: self x / vector x
		y: self y / vector y