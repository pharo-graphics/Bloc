event management
fireEvent: anEvent target: anEventTarget
	<return: #BlEvent>
	| theEvent aDispatcherChain |

	theEvent := anEvent.

	anEvent hasSource
		ifFalse: [ anEvent source: anEventTarget ].

	anEvent target = anEventTarget
		ifFalse: [ theEvent := anEvent newCopyFor: anEventTarget].

	aDispatcherChain := anEventTarget buildEventDispatchChain: BlEventDispatcherChain empty.
	^ aDispatcherChain dispatchEvent: theEvent