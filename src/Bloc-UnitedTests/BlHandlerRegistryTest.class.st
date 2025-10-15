"
I contain examples of event handler registry with Announcer as its backend

"
Class {
	#name : #BlHandlerRegistryTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Handler'
}

{ #category : #testing }
BlHandlerRegistryTest class >> isAbstract [

	^ self == BlHandlerRegistryTest
]

{ #category : #'instance creation' }
BlHandlerRegistryTest >> newRegistryToTest [

	^ self subclassResponsibility
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDown [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.

	self assert: aRegistry numberOfHandlers equals: 0.

	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).

	self assert: aRegistry numberOfHandlers equals: 1
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownAndMouseUp [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	self assert: aRegistry numberOfHandlers equals: 2
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownTwice [
		
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).

	self assert: aRegistry numberOfHandlers equals: 2
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownTwiceAndMouseUp [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	self assert: aRegistry numberOfHandlers equals: 3
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveAllMouseDownFromTwice [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).

	aRegistry removeAllSuchThat: [ :aHandler |
		(aHandler isKindOf: BlEventHandler) and: [
			aHandler eventClass = BlMouseDownEvent ] ].

	self assert: aRegistry numberOfHandlers equals: 0
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveAllMouseDownFromTwiceLeaveUp [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	aRegistry removeAllSuchThat: [ :aHandler |
		(aHandler isKindOf: BlEventHandler) and: [
			aHandler eventClass = BlMouseDownEvent ] ].

	self assert: aRegistry numberOfHandlers equals: 1
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveMouseDownLeaveEmpty [

	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	aRegistry remove:
		(aRegistry handlers detect: [ :aHandler |
			aHandler eventClass = BlMouseUpEvent]).
	aRegistry remove:
		(aRegistry handlers detect: [ :aHandler |
			aHandler eventClass = BlMouseDownEvent ]).

	self assert: aRegistry numberOfHandlers equals: 0
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveMouseUpLeaveMouseDown [
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseUpEvent]).

	self assert: aRegistry numberOfHandlers equals: 1
]
