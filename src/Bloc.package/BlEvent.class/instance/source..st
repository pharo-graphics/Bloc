accessing
source: aBlEventTarget
	
	self
		assert: [ self hasSource not ]
		description: [ 'Source can not be changed' ].
	
	source := aBlEventTarget