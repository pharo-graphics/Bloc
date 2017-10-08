instance creation
x: aX y: aY z: aZ
	self
		assert: [ ((aX * aX) + (aY * aY) + (aZ * aZ)) = 1 ]
		description: [ 'Unit vector must have length equal 1' ].

	^ super x: aX y: aY z: aZ