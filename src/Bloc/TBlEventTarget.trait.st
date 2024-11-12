"
I implement a basic infrastructure of event management.
Any object that needs to be able to handle events should use me.
"
Trait {
	#name : #TBlEventTarget,
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #'event management' }
TBlEventTarget >> addEventFilter: anEventHandler [
	self eventDispatcher addEventFilter: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventFilterOn: anEventClass do: aBlock [

	| newEventHandler |
	newEventHandler :=
		BlEventHandler
			on: anEventClass
			do: aBlock.

	self addEventFilter: newEventHandler.
	
	^ newEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandler: anEventHandler [
	self eventDispatcher addEventHandler: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandlerIfNotPresent: anEventHandler [
	(self hasEventHandler: anEventHandler)
		ifTrue: [ ^ self ].

	self addEventHandler: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandlerOn: anEventClass do: aBlock [
	"Add a new event handler for the received event class, and answer the new handler."
	
	| newEventHandler |
	newEventHandler :=
		BlEventHandler
			on: anEventClass
			do: aBlock.

	self addEventHandler: newEventHandler.

	^ newEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandlerOn: anEventClass doOnce: aBlock [
	"Add an event handler that will be removed right before culling the received block closure.
	Answer the new `BlEventHandler`."

	| anEventHandler |
	anEventHandler := BlEventHandler new.
	anEventHandler
		eventClass: anEventClass;
		action: [ :anEvent |
			self removeEventHandler: anEventHandler.
			aBlock cull: anEvent ].
	
	self addEventHandler: anEventHandler.
	
	^ anEventHandler
]

{ #category : #'shortcut management' }
TBlEventTarget >> addShortcut: aShortcut [
	self eventDispatcher addShortcut: aShortcut
]

{ #category : #'event management' }
TBlEventTarget >> buildEventDispatchChain: aBlEventDispatcherChain [
	"Note: Dispatcher chain is persistent - I return a new instance"
	<return: #BlEventDispatcherChain>
	| aResultChain |

	aResultChain := aBlEventDispatcherChain.
	aResultChain := aResultChain withNext: self eventDispatcher.

	self hasNextEventTarget
		ifTrue: [ aResultChain := self nextEventTarget buildEventDispatchChain: aResultChain ].

	^ aResultChain
]

{ #category : #'event management' }
TBlEventTarget >> buildEventDispatchChain: aBlEventDispatcherChain upTo: anOtherEventTarget [
	"Build an event dispatch chain up to but excluding a given other event target
	Note: Dispatcher chain is persistent - I return a new instance"
	<return: #BlEventDispatcherChain>
	| aResultChain |

	aResultChain := aBlEventDispatcherChain.
	aResultChain := aResultChain withNext: self eventDispatcher.

	(self hasNextEventTarget and: [ self nextEventTarget ~~ anOtherEventTarget ])
		ifTrue: [ aResultChain := self nextEventTarget buildEventDispatchChain: aResultChain upTo: anOtherEventTarget ].

	^ aResultChain
]

{ #category : #'event management' }
TBlEventTarget >> dispatchEvent: anEvent [
	"Dispatch an event if my dispatcher wants it. Previously, set in the event target, forwarding target, and source (if it wasn't already set)."

	anEvent hasSource ifFalse: [ anEvent source: self ].

	anEvent target: self.
	anEvent forwardingTarget: self.

	(self eventDispatcher wantsEvent: anEvent) ifTrue: [
		self eventDispatcher dispatchEvent: anEvent ]
]

{ #category : #'event management accessing' }
TBlEventTarget >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ self explicitRequirement
]

{ #category : #'event management' }
TBlEventTarget >> fireEvent: anEvent [
	"I fire provided event building an event dispatcher chain
	(from target to the root element) and dispatch the event with it."

	| aDispatcherChain |

	anEvent hasSource
		ifFalse: [ anEvent source: self ].

	anEvent target: self.

	aDispatcherChain := self buildEventDispatchChain: BlEventDispatcherChain empty.
	aDispatcherChain dispatchEvent: anEvent
]

{ #category : #'event management' }
TBlEventTarget >> hasEventFilter: anEventHandler [
	^ self eventDispatcher hasFilter: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> hasEventHandler: anEventHandler [
	^ self eventDispatcher hasHandler: anEventHandler
]

{ #category : #'event management accessing' }
TBlEventTarget >> hasNextEventTarget [
	"Return true if this event target has a logical successor within a dispatch chain.
	For example, in case of visual components next event target is a parent, meaning
	that first event is handled by child and the dispatched to the parent if that event
	was not consumed"
	<return: #Boolean>

	^ false
]

{ #category : #'event management accessing' }
TBlEventTarget >> nextEventTarget [
	"Return next event target that should be contained in dispatch chain.
	Note: returned object must use TBlEventTarget trait!"
	<return: #TBlEventTarget>

	self error: 'Override me if there is a next event target.'
]

{ #category : #'event management' }
TBlEventTarget >> removeEventFilter: anEventHandler [
	self eventDispatcher removeEventFilter: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> removeEventFiltersSuchThat: aBlock [
	self eventDispatcher removeEventFiltersSuchThat: aBlock
]

{ #category : #'event management' }
TBlEventTarget >> removeEventHandler: anEventHandler [
	self eventDispatcher removeEventHandler: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> removeEventHandlersSuchThat: aBlock [
	self eventDispatcher removeEventHandlersSuchThat: aBlock
]

{ #category : #'shortcut management' }
TBlEventTarget >> removeShortcut: aShortcut [
	self eventDispatcher removeShortcut: aShortcut
]

{ #category : #'shortcut management' }
TBlEventTarget >> removeShortcutsWithCombination: aBlKeyCombination [
	self eventDispatcher removeAllShortcutsWithCombination: aBlKeyCombination
]

{ #category : #'shortcut management' }
TBlEventTarget >> shortcuts [
	<return: #BlShortcutRegistry>

	^ self eventDispatcher shortcutHandler shortcuts
]

{ #category : #'event management' }
TBlEventTarget >> when: anEventClass doOnce: aBlock [
	"Add an event handler that will be removed right before culling the received block closure."

	self
		deprecated: 'Use addEventHandlerOn:doOnce: instead'
		transformWith: '`@receiver when: `@arg1 doOnce: `@arg2'
			-> '`@receiver addEventHandlerOn: `@arg1 doOnce: `@arg2'.

	^ self addEventHandlerOn: anEventClass doOnce: aBlock
]
