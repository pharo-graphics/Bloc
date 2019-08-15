Class {
	#name : #SharedPriorityUniqueQueueExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #tests }
SharedPriorityUniqueQueueExamples >> testQueuePriority [
	<gtExample>

	| queue |

	queue := SharedPriorityUniqueQueue new.
	queue
		nextPut: (SharedPriorityQueueTestEntry priority: 0);
		nextPut: (SharedPriorityQueueTestEntry priority: 5);
		nextPut: (SharedPriorityQueueTestEntry priority: 6);
		nextPut: (SharedPriorityQueueTestEntry priority: 8);
		nextPut: (SharedPriorityQueueTestEntry priority: 7);
		nextPut: (SharedPriorityQueueTestEntry priority: 1).

	self assert: queue next priority equals: 0.
	self assert: queue size equals: 5.

	self assert: queue next priority equals: 1.
	self assert: queue size equals: 4.

	self assert: queue next priority equals: 5.
	self assert: queue size equals: 3.

	self assert: queue next priority equals: 6.
	self assert: queue size equals: 2.

	self assert: queue next priority equals: 7.
	self assert: queue size equals: 1.

	self assert: queue next priority equals: 8.
	self assert: queue size equals: 0.

	self assert: queue nextOrNil isNil.
	self assert: queue size equals: 0.

	^queue
]

{ #category : #tests }
SharedPriorityUniqueQueueExamples >> testQueuePriorityAndIdentity [
	<gtExample>

	| queue |

	queue := SharedPriorityUniqueQueue new.
	queue
		nextPut: (SharedPriorityQueueTestEntry priority: 0);
		nextPut: (SharedPriorityQueueTestEntry priority: 5);
		nextPut: (SharedPriorityQueueTestEntry priority: 6 identifier: #unique);
		nextPut: (SharedPriorityQueueTestEntry priority: 8);
		"The next entry isn't added to the queue because an existing
		entry has the same identifier"
		nextPut: (SharedPriorityQueueTestEntry priority: 7 identifier: #unique);
		nextPut: (SharedPriorityQueueTestEntry priority: 1).

	self assert: queue size equals: 5.

	self assert: queue next priority equals: 0.
	self assert: queue size equals: 4.

	self assert: queue next priority equals: 1.
	self assert: queue size equals: 3.

	self assert: queue next priority equals: 5.
	self assert: queue size equals: 2.

	self assert: queue next priority equals: 6.
	self assert: queue size equals: 1.

	self assert: queue next priority equals: 8.
	self assert: queue size equals: 0.

	self assert: queue nextOrNil isNil.
	self assert: queue size equals: 0.

	^queue
]
