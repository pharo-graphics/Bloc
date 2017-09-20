accessing
referenceElement
	"Return a reference element that defines a coordinate system in which bounds are local.
	Reference element can not be nil"
	<return: #BlElement>
	self
		assert: [ referenceElement isNotNil ]
		description: [ 'Can not access not existing reference element' ].

	^ referenceElement