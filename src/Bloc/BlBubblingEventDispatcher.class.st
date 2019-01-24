Class {
	#name : #BlBubblingEventDispatcher,
	#superclass : #BlDirectEventDispatcher,
	#category : #'Bloc-Events-Handling'
}

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchArrivedEvent: anEvent [
	
	anEvent arrivedTarget: self owner.
	
	"handlers initialized lazily, do nothing if there are none of them"
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
	
	"handlers initialized lazily, do nothing if there are none of them"
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
	
	"filters initialized lazily, do nothing if there are none of them"
	filters ifNotNil: [ :theFilters |
		theFilters dispatchEvent: anEvent ]
]

{ #category : #dispatching }
BlBubblingEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [
	<return: #BlEvent>
	
	anEvent isConsumed
		ifTrue: [ ^ anEvent ].
		
	self dispatchCapturingEvent: anEvent.

	anEvent isConsumed
		ifTrue: [ ^ anEvent ].	

	anEvent canBePropagated
		ifTrue: [ aBlEventDispatcherChain dispatchEvent: anEvent ].

	anEvent isConsumed
		ifTrue: [ ^ anEvent ].

	self owner == anEvent target
		ifTrue: [ self dispatchArrivedEvent: anEvent ]
		ifFalse: [ self dispatchBubblingEvent: anEvent ].

	^ anEvent
]

{ #category : #'api - accessing' }
BlBubblingEventDispatcher >> type [
	<return: #String>

	^ 'Bubbling'
]
