accessing
referenceElement: anElement
	referenceElement := anElement.
	referenceElement
		addEventHandlerOn: BlElementPositionInSpaceChangedEvent
		do: [ :anEvent | self dispatchMoveEvent ]