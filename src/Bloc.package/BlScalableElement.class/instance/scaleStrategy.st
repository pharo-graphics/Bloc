accessing
scaleStrategy
	"Return scale strategy used to compute scaling factor of the content element"
	self
		assert: [ scaleStrategy isNotNil ]
		description: [ 'Scale strategy can not be nil' ].
		
	^ scaleStrategy