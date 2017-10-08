private
computedUnitVector
	<return: #BlUnitVector>
	| aLength |
	
	aLength := self length.
	self
		assert: [ aLength isZero not ]
		description: [ 'It is not possible to normalize a zero vector' ].

	^ BlUnitVector
		x: self x / aLength
		y: self y / aLength
		z: self z / aLength