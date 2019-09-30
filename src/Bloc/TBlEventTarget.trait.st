"
I implement a basic infrastructure of event management.
Any object that needs to be able to handle events should use me.
"
Trait {
	#name : #TBlEventTarget,
	#category : #'Bloc-Events-Handling'
}

{ #category : #'event management' }
TBlEventTarget >> addEventFilter: anEventHandler [
	self eventDispatcher addEventFilter: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventFilterOn: anEventClass do: aBlock [
	self addEventFilter: (BlEventHandler on: anEventClass do: aBlock)
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandler: anEventHandler [
	self eventDispatcher addEventHandler: anEventHandler
]

{ #category : #'event management' }
TBlEventTarget >> addEventHandlerOn: anEventClass do: aBlock [
	self addEventHandler: (BlEventHandler on: anEventClass do: aBlock)
]

{ #category : #'shortcut management' }
TBlEventTarget >> addShortcut: aShortcut [
	self shortcuts add: aShortcut
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
TBlEventTarget >> dispatchEvent: anEvent [
	"I only call my event dispatcher, so the event can be only handled by my event handlers/filters"

	anEvent hasSource
		ifFalse: [ anEvent source: anEvent ].

	anEvent target: self.
	anEvent forwardingTarget: self.

	(self eventDispatcher wantsEvent: anEvent)
		ifTrue: [ self eventDispatcher dispatchEvent: anEvent ]
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
	(from target to the root element) and dispatch the event with it.
	anEvent must not be nil"

	BlEvent fireEvent: anEvent target: self
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
	self shortcuts remove: aShortcut
]

{ #category : #'shortcut management' }
TBlEventTarget >> removeShortcutsWithCombination: aBlKeyCombination [
	self shortcuts removeAllWithCombination: aBlKeyCombination
]

{ #category : #'shortcut management' }
TBlEventTarget >> shortcuts [
	<return: #BlShortcutRegistry>

	^ self eventDispatcher shortcutHandler shortcutRegistry
]

{ #category : #'event management' }
TBlEventTarget >> when: anEventClass do: aBlock [
	self addEventHandlerOn: anEventClass do: aBlock
]
