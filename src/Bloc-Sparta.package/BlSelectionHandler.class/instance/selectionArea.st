geometry
selectionArea
	"Return selection area given in space coordinates"
	<return: #Rectangle>
	
	self
		assert: [ origin isNotNil and: [ corner isNotNil ] ]
		description: [ 'Selection origin and corner must be known' ].

	^ origin corner: corner