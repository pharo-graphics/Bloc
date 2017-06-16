accessing
root
	"Return my current root element.
	root can not be nil"
	<return: #BlElement>
	
	self
		assert: [ root isNotNil ]
		description: [ 'Root must not be nil' ].
	
	^ root