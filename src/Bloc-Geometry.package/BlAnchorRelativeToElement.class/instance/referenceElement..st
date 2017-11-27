accessing
referenceElement: anElement
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].

	self
		assert: [ referenceElement isNil ]
		description: [ 'Reference element can not be changed once set' ].

	referenceElement := anElement.
	referenceElement
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ].
	referenceElement
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ]