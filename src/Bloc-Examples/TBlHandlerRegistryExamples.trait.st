"
I define examples of the public api of event handler registry. All concrete implementations should behave in the same way
"
Trait {
	#name : #TBlHandlerRegistryExamples,
	#category : 'Bloc-Examples-EventHandling'
}

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> addMouseDown [
	<gtExample>
	| aRegistry |
	
	aRegistry := self emptyRegistry.
	self assert: aRegistry numberOfHandlers equals: 0.
	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> addMouseDownAndMouseUp [
	<gtExample>
	| aRegistry |

	aRegistry := self addMouseDown.
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	
	self assert: aRegistry numberOfHandlers equals: 2.
	
	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> addMouseDownTwice [
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDown.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseDownEvent).
	
	self assert: aRegistry numberOfHandlers equals: 2.
	
	^ aRegistry
]

{ #category : #'examples - add' }
TBlHandlerRegistryExamples >> addMouseDownTwiceAndMouseUp [
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwice.	
	aRegistry add: (BlExampleLoggingEventHandler on: BlMouseUpEvent).
	
	self assert: aRegistry numberOfHandlers equals: 3.
	
	^ aRegistry
]

{ #category : #'instance creation' }
TBlHandlerRegistryExamples >> emptyRegistry [
	<return: #BlHandlerRegistry>

	^ self explicitRequirement
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> removeAllMouseDownFromTwice [
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwice.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	
	self assert: aRegistry numberOfHandlers equals: 0.
	
	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> removeAllMouseDownFromTwiceLeaveUp [
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownTwiceAndMouseUp.
	aRegistry removeAllSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler) and: [ aHandler eventClass = BlMouseDownEvent ] ].
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> removeMouseDownLeaveEmpty [
	<gtExample>
	| aRegistry |
	
	aRegistry := self removeMouseUpLeaveMouseDown.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseDownEvent]).
	
	self assert: aRegistry numberOfHandlers equals: 0.
	
	^ aRegistry
]

{ #category : #'examples - remove' }
TBlHandlerRegistryExamples >> removeMouseUpLeaveMouseDown [
	<gtExample>
	| aRegistry |
	
	aRegistry := self addMouseDownAndMouseUp.
	aRegistry remove: (aRegistry handlers detect: [ :aHandler | aHandler eventClass = BlMouseUpEvent]).
	
	self assert: aRegistry numberOfHandlers equals: 1.
	
	^ aRegistry
]
