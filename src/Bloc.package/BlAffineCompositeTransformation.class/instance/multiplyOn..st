testing
multiplyOn: aBlMatrix
	self transformations do: [ :aTransformation | aTransformation multiplyOn: aBlMatrix ]