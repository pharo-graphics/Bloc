event management
buildEventDispatchChain: aBlEventDispatcherChain
	"Note: Dispatcher chain is persistent - I return a new instance"
	<return: #BlEventDispatcherChain>
	| aResultChain |

	aResultChain := aBlEventDispatcherChain.
	aResultChain := aResultChain withNext: self eventDispatcher.

	self hasNextEventTarget
		ifTrue: [ aResultChain := self nextEventTarget buildEventDispatchChain: aResultChain ].

	^ aResultChain