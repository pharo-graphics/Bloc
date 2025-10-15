"
I'm a handler registry based on `Array`.
"
Class {
	#name : #BlHandlerArrayRegistry,
	#superclass : #BlHandlerRegistry,
	#instVars : [
		'handlers'
	],
	#category : #'Bloc-Events-Dispatcher'
}

{ #category : #testing }
BlHandlerArrayRegistry class >> isSupported [
	
	^ true
]

{ #category : #printing }
BlHandlerArrayRegistry class >> label [

	^ 'Custom (Array)'
]

{ #category : #accessing }
BlHandlerArrayRegistry class >> priority [

	^ 2
]

{ #category : #'api - adding / removing' }
BlHandlerArrayRegistry >> add: aHandler [
	"Adds a given event handler to the registry.
	aHandler must not be nil and must not be already registered"
	
	self
		assert: [ aHandler isNotNil ]
		description: [ 'Handler must not be nil!' ].

	self
		assert: [ (handlers includes: aHandler) not ]
		description: [ 'Handler must not be registered!' ].

	handlers := handlers copyWith: aHandler
]

{ #category : #'api - event managing' }
BlHandlerArrayRegistry >> dispatchEvent: anEvent [
	"Dispatch a given event to all registered handlers that are interested in it"
	| theHandlers |

	"inlined version of select:thenDo:"
	theHandlers := handlers. "we must store reference to previous handlers"
	1 to: theHandlers size do: [ :index | | each |
		((each := theHandlers at: index) wantsEvent: anEvent)
			ifTrue: [
				anEvent prepareForDelivery.
				each handleEvent: anEvent ] ]
]

{ #category : #'api - enumerating' }
BlHandlerArrayRegistry >> do: aBlock [
	"Evaluate aBlock with each registered handler as the argument"
	
	handlers do: aBlock
]

{ #category : #'api - accessing' }
BlHandlerArrayRegistry >> handlers [
	"Return an immutable collection of all registered event handlers"
	<return: #Array of: #BlBasicEventHandler>

	^ handlers
]

{ #category : #initialization }
BlHandlerArrayRegistry >> initialize [
	super initialize.

	handlers := Array new
]

{ #category : #'api - enumerating' }
BlHandlerArrayRegistry >> numberOfHandlers [
	"Return amount of registered event handlers"
	<return: #Number>

	^ self handlers size
]

{ #category : #'api - adding / removing' }
BlHandlerArrayRegistry >> remove: aHandler [
	"Remove given event handler from my registry.
	Provided handler must not be nil and must be registered"
	
	self
		assert: [ aHandler isNotNil ]
		description: [ 'Handler must not be nil!' ].

	self
		assert: [ handlers includes: aHandler ]
		description: [ 'Handler must be registered!' ].

	handlers := handlers copyWithout: aHandler
]

{ #category : #'api - adding / removing' }
BlHandlerArrayRegistry >> removeAllSuchThat: aBlock [
	"Remove all event handlers for which aBlock returns true.
	Return a collection of removed handlers"
	<return: #SequenceableCollection of: #BlBasicEventHandler>
	| toBeRemoved |

	toBeRemoved := handlers select: aBlock.
	handlers := handlers reject: aBlock.

	^ toBeRemoved
]
