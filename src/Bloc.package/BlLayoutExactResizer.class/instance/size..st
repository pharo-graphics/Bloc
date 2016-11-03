accessing
size: aNumber
	self
		assert: [ size isNil ]
		description: [ 'Size can not be changed once set (immutability)' ].
		
	size := aNumber