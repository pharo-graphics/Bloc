geometry
positionFor: anElement
	<return: #Point>
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].
	
	^ (self overlayElement globalPointToParent: anElement bounds inSpace position)