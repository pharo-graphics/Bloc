children - accessing
childHolderOf: aChildElement
	"Return an element holder assigned to my direct child.
	aChildElement must be my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>

	self
		assert: [ aChildElement parent == self ]
		description: [ 'aChildElement must be my direct child!' ].

	^ self elementHolderOf: aChildElement