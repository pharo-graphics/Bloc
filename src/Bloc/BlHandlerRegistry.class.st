"
I am an event handler registry used by dispatchers in order to manage event handlers.

Example:
[[[
| registry |
""one can use announcer based registry""
registry := BlHandlerAnnouncerRegistry new.
""or registry based on plain array""
registry := BlHandlerArrayRegistry new.
registry add: (BlEventHandler on: BlClickEvent do: [ self inform: 'Click' ] ).
registry add: (BlEventHandler on: BlMouseDownEvent do: [ self inform: 'Mouse down' ] ).
registry add: (BlEventHandler on: BlMouseUpEvent do: [ self inform: 'Mouse up' ] ).
registry dispatchEvent: BlClickEvent new.
registry dispatchEvent: BlMouseDownEvent new.
registry dispatchEvent: BlMouseUpEvent new.
]]]
"
Class {
	#name : #BlHandlerRegistry,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Events-Handling'
}

{ #category : #accessing }
BlHandlerRegistry class >> availableRegistryClasses [
	<return: #Collection of: #'BlHandlerRegistry class'>

	^ self allSubclasses select: [ :aRegistryClass | aRegistryClass isSupported ]
]

{ #category : #testing }
BlHandlerRegistry class >> isSupported [
	<return: #Boolean>
	
	^ false
]

{ #category : #accessing }
BlHandlerRegistry class >> label [
	"Return a name of the registry, can be used for Settings frameworks"
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #'api - adding / removing' }
BlHandlerRegistry >> add: aHandler [
	"Adds a given event handler to the registry.
	aHandler must not be nil and must not be already registered"
	
	self subclassResponsibility
]

{ #category : #'api - enumerating' }
BlHandlerRegistry >> anySatisfy: aBlock [
	"Evaluate aBlock with every registered event handler.
	If aBlock returns true for any element return true.
	Otherwise return false."
	<return: #Boolean>

	self do: [ :aHandler | (aBlock value: aHandler) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - event managing' }
BlHandlerRegistry >> dispatchEvent: anEvent [
	"Dispatch a given event to all registered handlers that are interested in it"

	self subclassResponsibility
]

{ #category : #'api - enumerating' }
BlHandlerRegistry >> do: aBlock [
	"Evaluate aBlock with each registered handler as the argument"

	self subclassResponsibility
]

{ #category : #'api - accessing' }
BlHandlerRegistry >> handlers [
	"Return an immutable collection of all registered event handlers"
	<return: #Array of: #TBlEventHandler>

	^ self subclassResponsibility
]

{ #category : #'api - testing' }
BlHandlerRegistry >> hasHandler: anEventHandler [
	"Return true if a given event handler is registered, false otherwise"
	<return: #Boolean>

	^ self anySatisfy: [ :each | each = anEventHandler ]
]

{ #category : #'api - testing' }
BlHandlerRegistry >> isEmpty [
	"Return true if registry is empty (there are no handlers), false otherwise"
	<return: #Boolean>

	^ self numberOfHandlers isZero
]

{ #category : #'api - enumerating' }
BlHandlerRegistry >> numberOfHandlers [
	"Return amount of registered event handlers"
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'api - adding / removing' }
BlHandlerRegistry >> remove: aHandler [
	"Remove given event handler from my registry.
	Provided handler must not be nil and must be registered"
	
	self subclassResponsibility
]

{ #category : #'api - adding / removing' }
BlHandlerRegistry >> removeAllSuchThat: aBlock [
	"Remove all event handlers for which aBlock returns true.
	Return a collection of removed handlers"
	<return: #SequenceableCollection of: #BlBasicEventHandler>
	
	^ self subclassResponsibility
]
