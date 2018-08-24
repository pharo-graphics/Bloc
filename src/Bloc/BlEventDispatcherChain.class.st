"
I am a chain of BlEventDispatcher
"
Class {
	#name : #BlEventDispatcherChain,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'next',
		'previous',
		'dispatcher'
	],
	#category : 'Bloc-EventHandling'
}

{ #category : #'instance creation' }
BlEventDispatcherChain class >> empty [
	<return: #BlEventDispatcherChain>
	
	^ BlEventDispatcherEmptyChain uniqueInstance
]

{ #category : #'instance creation' }
BlEventDispatcherChain class >> with: aBlEventDispatcher [
	^ self new initializeWith: aBlEventDispatcher
]

{ #category : #'api - event managing' }
BlEventDispatcherChain >> dispatchEvent: anEvent [
	"Dispatch a given event through the whole dispatcher chain"
	| aPreviousChain |

	aPreviousChain := self hasPrevious
		ifTrue: [ self previous ]
		ifFalse: [ self class empty ].

	^ self dispatcher dispatchEvent: anEvent next: aPreviousChain
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> dispatcher [
	<return: #BlEventDispatcher>

	self
		assert: [ dispatcher isNotNil ]
		description: [ 'Dispatcher must not be nil' ].
	
	^ dispatcher
]

{ #category : #'api - accessing' }
BlEventDispatcherChain >> first [
	^ self hasPrevious
		ifTrue: [ self previous first ]
		ifFalse: [ self ]
]

{ #category : #'private - testing' }
BlEventDispatcherChain >> hasDispatcher [
	<return: #Boolean>
	
	^ dispatcher isNotNil
]

{ #category : #'private - testing' }
BlEventDispatcherChain >> hasNext [
	<return: #Boolean>
	
	^ next isNotNil
]

{ #category : #'private - testing' }
BlEventDispatcherChain >> hasPrevious [
	<return: #Boolean>
	
	^ previous isNotNil
]

{ #category : #initialization }
BlEventDispatcherChain >> initializeWith: aBlEventDispatcher [

	self
		assert: [ dispatcher isNil ]
		description: [ 'I am immutable. Create a new chain for a given dispatcher' ].

	dispatcher := aBlEventDispatcher.
	
	"explicitly log that new chain has no successor or predecessor"
	previous := nil.
	next := nil
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> next [
	<return: #BlEventDispatcherChain>
	
	self
		assert: [ self hasNext ]
		description: [ 'Can not access next element in a chain if it does not exist' ].
	
	^ next
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> next: aBlEventDispatcherChain [
	self
		assert: [ self hasNext not ]
		description: [ 'I am immutable' ].

	next := aBlEventDispatcherChain
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> previous [
	<return: #BlEventDispatcherChain>
	
	self
		assert: [ self hasPrevious ]
		description: [ 'Can not access previous element in a chain if it does not exist' ].
	
	^ previous
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> previous: aBlEventDispatcherChain [
	self
		assert: [ self hasPrevious not ]
		description: [ 'I am immutable' ].

	previous := aBlEventDispatcherChain
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> withAllNext [
	<return: #SequenceableCollection of: #BlEventDispatcherChain>

	^ Array streamContents: [ :aStream |
		| aChain |
		aChain := self.
		aStream nextPut: aChain.
		[ aChain hasNext ] whileTrue: [
			aStream nextPut: aChain next.
			aChain := aChain next ] ]
]

{ #category : #'private - accessing' }
BlEventDispatcherChain >> withAllPrevious [
	<return: #SequenceableCollection of: #BlEventDispatcherChain>

	^ Array streamContents: [ :aStream |
		| aChain |
		aChain := self.
		aStream nextPut: aChain.
		[ aChain hasPrevious ] whileTrue: [
			aStream nextPut: aChain previous.
			aChain := aChain previous ] ]
]

{ #category : #'api - adding' }
BlEventDispatcherChain >> withNext: aBlEventDispatcher [
	| aNextChain |

	aNextChain := self class with: aBlEventDispatcher.
	self next: aNextChain.
	aNextChain previous: self.

	^ aNextChain
]
