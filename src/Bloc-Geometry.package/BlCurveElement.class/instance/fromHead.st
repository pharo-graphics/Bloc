heads - accessing
fromHead
	<return: #BlElement>

	self
		assert: [ self hasFromHead ]
		description: [ 'Can only access arrowhead on the `from` side of the curve if it exists' ].
		
	^ fromHead