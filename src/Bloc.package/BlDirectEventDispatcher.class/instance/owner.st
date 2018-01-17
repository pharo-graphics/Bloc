api - accessing
owner
	<return: #TBlEventTarget>

	self
		assert: [ owner isNotNil ]
		description: [ 'Can not access owner if it does not exist' ].

	^ owner