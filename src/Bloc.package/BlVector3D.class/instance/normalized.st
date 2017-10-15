vector functions
normalized
	<return: #BlVector>
	| aLength |
	
	aLength := self length.
	self
		assert: [ aLength isZero not ]
		description: [ 'It is not possible to normalize a zero vector' ].

	^ self class
		x: self x / aLength
		y: self y / aLength
		z: self z / aLength