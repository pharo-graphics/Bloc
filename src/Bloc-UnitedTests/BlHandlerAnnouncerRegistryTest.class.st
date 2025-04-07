"
I contain examples of event handler registry with Announcer as its backend

"
Class {
	#name : #BlHandlerAnnouncerRegistryTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Handler'
}

{ #category : #'instance creation' }
BlHandlerAnnouncerRegistryTest >> emptyRegistry [

	^ BlHandlerAnnouncerRegistry new
]

{ #category : #'examples - add' }
BlHandlerAnnouncerRegistryTest >> testAddMouseDown [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self emptyRegistry.
	self assert: aRegistry numberOfHandlers equals: 0.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerAnnouncerRegistryTest >> testAddMouseDownAndMouseUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerAnnouncerRegistryTest >> testAddMouseDownTwice [
	<sampleInstance>
		
	| aRegistry |
	aRegistry := self testAddMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerAnnouncerRegistryTest >> testAddMouseDownTwiceAndMouseUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	self assert: aRegistry numberOfHandlers equals: 3.
	^ aRegistry
]

{ #category : #'examples - add' }
BlHandlerAnnouncerRegistryTest >> testAddMouseDownTwiceror [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	self assert: aRegistry numberOfHandlers equals: 2.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerAnnouncerRegistryTest >> testRemoveAllMouseDownFromTwice [
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	self assert: aRegistry numberOfHandlers equals: 0.

	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerAnnouncerRegistryTest >> testRemoveAllMouseDownFromTwiceLeaveUp [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownTwiceAndMouseUp.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerAnnouncerRegistryTest >> testRemoveMouseDownLeaveEmpty [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testRemoveMouseUpLeaveMouseDown.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseDownEvent]).
	self assert: aRegistry numberOfHandlers equals: 0.
	^ aRegistry
]

{ #category : #'examples - remove' }
BlHandlerAnnouncerRegistryTest >> testRemoveMouseUpLeaveMouseDown [
	<sampleInstance>
	
	| aRegistry |
	aRegistry := self testAddMouseDownAndMouseUp.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseUpEvent]).
	self assert: aRegistry numberOfHandlers equals: 1.
	^ aRegistry
]
