heads - accessing
toHead
	<return: #BlElement>

	self
		assert: [ self hasToHead ]
		description: [ 'Can only access arrowhead on the `to` side of the curve if it exists' ].
		
	^ toHead