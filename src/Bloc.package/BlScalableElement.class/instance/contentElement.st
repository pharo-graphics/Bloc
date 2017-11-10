accessing
contentElement
	"Return a content element that is being scaled"
	<return: #BlElement>

	self
		assert: [ contentElement isNotNil ]
		description: [ 'Can not access a content element when it is not provided' ].

	^ contentElement