"
I dispatch events directly to the registered event handlers.
"
Class {
	#name : #BlDirectEventDispatcher,
	#superclass : #BlEventDispatcher,
	#instVars : [
		'owner',
		'filters',
		'handlers',
		'shortcutHandler'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #'instance creation' }
BlDirectEventDispatcher class >> on: aTBlEventTarget [

	^ self new
		owner: aTBlEventTarget;
		yourself
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> addEventFilter: aFilter [
	"Event filters receive events before general event handlers.
	Their main goal is to prevent some specific events from being handled by basic handlers.
	For that custom filters should mark event as ==consumed: true== which instantly stops propagation"

	"Lazy initialization"
	filters ifNil: [ filters := self newFilterRegistry ].
	filters add: aFilter.

	"send hook AFTER filter is added"
	aFilter onInstalledIn: self owner
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> addEventHandler: aHandler [

	"Lazy initialization"
	handlers ifNil: [ handlers := self newHandlerRegistry ].
	handlers add: aHandler.

	"send hook AFTER handler is added"
	aHandler onInstalledIn: self owner
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> addShortcut: aBlShortcut [

	shortcutHandler := shortcutHandler addShortcut: aBlShortcut
]

{ #category : #'api - event managing' }
BlDirectEventDispatcher >> dispatchEvent: anEvent next: aBlEventDispatcherChain [

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	anEvent target == self owner
		ifTrue: [ anEvent arrivedTarget: self owner ]
		ifFalse: [ anEvent forwardingTarget: self owner ].

	"filters initialized lazily, do nothing if there are none of them"
	filters ifNotNil: [ :theFilters | theFilters dispatchEvent: anEvent ].

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	"handlers initialized lazily, do nothing if there are none of them"
	handlers ifNotNil: [ :theHandlers |
		theHandlers dispatchEvent: anEvent ].

	anEvent isConsumed ifTrue: [ ^ anEvent ].

	"shortcutHandler is special case, treat it differently"
	(shortcutHandler wantsEvent: anEvent) ifTrue: [
		shortcutHandler handleEvent: anEvent ].

	^ anEvent
]

{ #category : #'api - accessing' }
BlDirectEventDispatcher >> filtersDo: aBlock [
	"Evaulate a given block with every event filter as an argument"

	filters ifNotNil: [ :aRegistry | aRegistry handlers do: aBlock ]
]

{ #category : #'api - accessing' }
BlDirectEventDispatcher >> handlersDo: aBlock [
	"Evaulate a given block with every event handler as an argument"

	handlers ifNotNil: [ :aRegistry | aRegistry handlers do: aBlock ]
]

{ #category : #'api - accessing' }
BlDirectEventDispatcher >> hasEventFilterSuchThat: aBlock [

	self filtersDo: [ :eachfilter |
		(aBlock value: eachfilter) ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'api - testing' }
BlDirectEventDispatcher >> hasFilter: anEventHandler [

	^ filters
		  ifNil: [ false ]
		  ifNotNil: [ filters hasHandler: anEventHandler ]
]

{ #category : #'api - testing' }
BlDirectEventDispatcher >> hasHandler: anEventHandler [

	^ handlers
		  ifNil: [ false ]
		  ifNotNil: [ handlers hasHandler: anEventHandler ]
]

{ #category : #initialization }
BlDirectEventDispatcher >> initialize [

	super initialize.

	"Note, that we do not expose filters and handlers to the outer worlds with getters because it is not part
	of our public api. Additionally we want to treat shortcutHandler differently. By convention
	shortcutHandler always presents in a simple dispatcher. It is not memory efficient to create an instance
	of handler registry just for a single shortcut handler, that we know, always presents.
	However, shortcut handler is of type handler and *virtually* belongs to handlers registry. It is just
	not visible to users, think of it as implementation detail"
	filters := nil. "BlHandlerRegistry"
	handlers := nil. "BlHandlerRegistry"
	shortcutHandler := BlShortcutHandlerWithoutShortcuts uniqueInstance
]

{ #category : #initialization }
BlDirectEventDispatcher >> newFilterRegistry [

	^ BlHandlerRegistry preferableHandlerRegistryClass new
]

{ #category : #initialization }
BlDirectEventDispatcher >> newHandlerRegistry [

	^ BlHandlerRegistry preferableHandlerRegistryClass new
]

{ #category : #'api - accessing' }
BlDirectEventDispatcher >> owner [

	^ owner
]

{ #category : #'private - accessing' }
BlDirectEventDispatcher >> owner: aTBlEventTarget [

	owner := aTBlEventTarget
]

{ #category : #printing }
BlDirectEventDispatcher >> printOn: aStream [

 	super printOn: aStream.
 	aStream
 		nextPutAll: '(owner: ';
 		nextPutAll: owner;
 		nextPut: $)
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeAllShortcutsWithCombination: aBlKeyCombination [

	shortcutHandler := shortcutHandler removeAllWithCombination: aBlKeyCombination
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeEventFilter: aFilter [

	(self hasFilter: aFilter) ifFalse: [ ^ self ].

	filters ifNil: [ ^ self ].
	filters remove: aFilter.
	"free memory as soon as we got rid of all event filters"
	filters isEmpty ifTrue: [ filters := nil ].

	aFilter onUninstalledIn: self owner
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeEventFiltersSuchThat: aBlock [
	"Remove all event handlers for those aBlock returns true"

	| toBeRemoved |
	filters ifNil: [ ^ self ].

	toBeRemoved := filters removeAllSuchThat: aBlock.
	filters isEmpty ifTrue: [ filters := nil ].

	toBeRemoved do: [ :aHandler | aHandler onUninstalledIn: self owner ]
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeEventHandler: anHandler [

	(self hasHandler: anHandler) ifFalse: [ ^ self ].

	handlers ifNil: [ ^ self ].
	handlers remove: anHandler.
	"free memory as soon as we got rid of all event handlers"
	handlers isEmpty ifTrue: [ handlers := nil ].

	anHandler onUninstalledIn: self owner
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeEventHandlers [
	"Remove all my event handlers"

	| oldHandlers |
	handlers ifNil: [ ^ self ].

	oldHandlers := handlers.
	handlers := nil.

	oldHandlers do: [ :eachHandler |
		eachHandler onUninstalledIn: self owner ]
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeEventHandlersSuchThat: aBlock [
	"Remove all event handlers for those aBlock returns true"

	| toBeRemoved |
	handlers ifNil: [ ^ self ].

	toBeRemoved := handlers removeAllSuchThat: aBlock.
	handlers isEmpty ifTrue: [ handlers := nil ].

	toBeRemoved do: [ :aHandler | aHandler onUninstalledIn: self owner ]
]

{ #category : #'api - adding/removing' }
BlDirectEventDispatcher >> removeShortcut: aBlShortcut [

	shortcutHandler := shortcutHandler removeShortcut: aBlShortcut
]

{ #category : #'private - accessing' }
BlDirectEventDispatcher >> shortcutHandler [

	^ shortcutHandler
]

{ #category : #'api - event managing' }
BlDirectEventDispatcher >> wantsEvent: anEvent [
	"Return true if there are any filters or handlers interesting in a given event,
	false otherwise"

	"first, ask shortcutHandler because it is always present"
	(shortcutHandler wantsEvent: filters) ifTrue: [ ^ true ].

	(filters isNotNil and: [
		filters anySatisfy: [ :aFilter | aFilter wantsEvent: anEvent ] ])
			ifTrue: [ ^ true ].

	(handlers isNotNil and: [
		handlers anySatisfy: [ :aHandler | aHandler wantsEvent: anEvent ] ])
			ifTrue: [ ^ true ].

	^ false
]
