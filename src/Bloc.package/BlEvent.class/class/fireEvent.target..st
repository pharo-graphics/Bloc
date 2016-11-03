as yet unclassified
fireEvent: anEvent target: anEventTarget
	| theEvent aTail |
	theEvent := anEvent.
	anEvent target = anEventTarget
		ifFalse: [ theEvent := anEvent newCopyFor: anEventTarget].
	aTail := anEventTarget buildEventDispatchChain: BlEventDispatcherChain new.
	aTail dispatchEvent: theEvent