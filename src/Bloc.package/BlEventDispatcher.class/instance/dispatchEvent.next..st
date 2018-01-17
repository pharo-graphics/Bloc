api - event managing
dispatchEvent: anEvent next: aBlEventDispatcherChain
	<return: #BlEvent>

	"Default implementation just dispaches to the next dispatcher in a chain"
	aBlEventDispatcherChain dispatchEvent: anEvent.

	^ anEvent