event managing
dispatchEvent: anEvent
	(BlEventDispatcherChain with: self) dispatchEvent: anEvent.
	^ anEvent