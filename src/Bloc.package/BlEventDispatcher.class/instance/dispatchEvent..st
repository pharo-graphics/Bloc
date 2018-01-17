api - event managing
dispatchEvent: anEvent
	<return: #BlEvent>

	^ self dispatchEvent: anEvent next: BlEventDispatcherChain empty