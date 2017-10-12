testing
multiplyOn: aBlMatrix in: aBlElement
	self transformations do: [ :aTransformation | aTransformation multiplyOn: aBlMatrix in: aBlElement ]