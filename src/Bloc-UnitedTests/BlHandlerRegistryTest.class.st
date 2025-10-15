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
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self newRegistryToTest.
	self assert: aRegistry numberOfHandlers equals: 0.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownAndMouseUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownTwice [
	<sampleInstance>
		
	| aRegistry |
	aRegistry := self testAddMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownTwiceAndMouseUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	self assert: aRegistry numberOfHandlers equals: 3.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerRegistryTest >> testAddMouseDownTwiceror [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveAllMouseDownFromTwice [
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	self assert: aRegistry numberOfHandlers equals: 0.

	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveAllMouseDownFromTwiceLeaveUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwiceAndMouseUp.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveMouseDownLeaveEmpty [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testRemoveMouseUpLeaveMouseDown.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseDownEvent]).
	self assert: aRegistry numberOfHandlers equals: 0.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerRegistryTest >> testRemoveMouseUpLeaveMouseDown [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownAndMouseUp.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseUpEvent]).
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]
