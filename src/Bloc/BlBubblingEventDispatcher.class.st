"
I'm an event dispatcher that makes events be handled by the element tree in two phases: the capturing and the bubbling phase. 

When an event is dispatched, the element tree can handle it in this specific order:
1. Event Capturing starts at the root element and moves downward to the target element.
2. Event Bubbling starts at the target element and moves upward through the element tree.

"
Class {
	#name : #BlBubblingEventDispatcher,
	#superclass : #BlDirectEventDispatcher,
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchArrivedEvent: anEvent [

	anEvent arrivedTarget: self owner.

	"Pay attention at lazy initialization"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	"shortcutHandler is special case, treat it differently but first check if
	event is consumed or not"
	(anEvent isConsumed not and: [ shortcutHandler wantsEvent: anEvent ])
		ifTrue: [ shortcutHandler handleEvent: anEvent ]
]

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchBubblingEvent: anEvent [

	anEvent bubblingTarget: self owner.

	"Pay attention at lazy initialization"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	"shortcutHandler is special case, treat it differently but first check if
	event is consumed or not"
	(anEvent isConsumed not and: [ shortcutHandler wantsEvent: anEvent ])
		ifTrue: [ shortcutHandler handleEvent: anEvent ]
]

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchCapturingEvent: anEvent [

	anEvent capturingTarget: self owner.

	"Pay attention at lazy initialization"
	filters ifNotNil: [ :theFilters |
		theFilters dispatchEvent: anEvent ]
]

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	"we give filters a chance to capture this event"
	self dispatchCapturingEvent: anEvent.

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	anEvent canBePropagated ifTrue: [
		aBlEventDispatcherChain dispatchEvent: anEvent ].

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	self owner == anEvent target
		ifTrue: [ self dispatchArrivedEvent: anEvent ]
		ifFalse: [ self dispatchBubblingEvent: anEvent ].

	^ anEvent
]
