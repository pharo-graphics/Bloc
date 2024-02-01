"
I define examples of the public api of event handler registry. All concrete implementations should behave in the same way
"
Trait {
	#name : #TBlHandlerRegistryExamples,
	#category : 'Bloc-Examples-EventHandling'
}

{ #category : #'instance creation' }
TBlHandlerRegistryExamples >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ self explicitRequirement
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> testAddMouseDown [

	<sampleInstance>
	| aRegistry |
	aRegistry := self emptyRegistry.
	self assert: aRegistry numberOfHandlers equals: 0.

	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).

	self assert: aRegistry numberOfHandlers equals: 1.

	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> testAddMouseDownAndMouseUp [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	self assert: aRegistry numberOfHandlers equals: 2.

	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> testAddMouseDownTwice [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).

	self assert: aRegistry numberOfHandlers equals: 2.

	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> testAddMouseDownTwiceAndMouseUp [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).

	self assert: aRegistry numberOfHandlers equals: 3.

	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> testRemoveAllMouseDownFromTwice [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDownTwice.
	aRegistry removeAllSuchThat: [ :aHandler |
		(aHandler isKindOf: BlEventHandler) and: [
			aHandler eventClass = BlMouseDownEvent ] ].

	self assert: aRegistry numberOfHandlers equals: 0.

	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> testRemoveAllMouseDownFromTwiceLeaveUp [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDownTwiceAndMouseUp.
	aRegistry removeAllSuchThat: [ :aHandler |
		(aHandler isKindOf: BlEventHandler) and: [
			aHandler eventClass = BlMouseDownEvent ] ].

	self assert: aRegistry numberOfHandlers equals: 1.

	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> testRemoveMouseDownLeaveEmpty [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testRemoveMouseUpLeaveMouseDown.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler |
			 aHandler eventClass = BlMouseDownEvent ]).

	self assert: aRegistry numberOfHandlers equals: 0.

	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> testRemoveMouseUpLeaveMouseDown [

	<sampleInstance>
	| aRegistry |
	aRegistry := self testAddMouseDownAndMouseUp.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler |
			 aHandler eventClass = BlMouseUpEvent ]).

	self assert: aRegistry numberOfHandlers equals: 1.

	^ aRegistry
]
