as yet unclassified
fireEvent: anEvent target: anEventTarget
	| theEvent aDispatcherChain |
	
	theEvent := anEvent.
	
	anEvent target = anEventTarget
		ifFalse: [ theEvent := anEvent newCopyFor: anEventTarget].

	aDispatcherChain := anEventTarget buildEventDispatchChain: BlEventDispatcherChain empty.
	aDispatcherChain first dispatchEvent: theEvent