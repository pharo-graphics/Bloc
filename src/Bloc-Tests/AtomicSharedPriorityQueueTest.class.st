"
This class contains tests

"
Class {
	#name : #AtomicSharedPriorityQueueTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-TaskIt'
}

{ #category : #tests }
AtomicSharedPriorityQueueTest >> testNextIfNone [

	| queue |

	"Test removing first element"
	queue := AtomicSharedPriorityQueue new.
	queue
		nextPut: (SharedPriorityQueueTestEntry priority: 0);
		nextPut: (SharedPriorityQueueTestEntry priority: 5);
		nextPut: (SharedPriorityQueueTestEntry priority: 6);
		nextPut: (SharedPriorityQueueTestEntry priority: 8);
		nextPut: (SharedPriorityQueueTestEntry priority: 7);
		nextPut: (SharedPriorityQueueTestEntry priority: 1).

	self assert: queue nextOrNil priority equals: 0.
	self assert: queue size equals: 5.
	self assert: queue itemCount equals: 5.

	self assert: queue nextOrNil priority equals: 1.
	self assert: queue size equals: 4.
	self assert: queue itemCount equals: 5.

	self assert: queue nextOrNil priority equals: 5.
	self assert: queue size equals: 3.
	self assert: queue itemCount equals: 4.

	self assert: queue nextOrNil priority equals: 6.
	self assert: queue size equals: 2.
	self assert: queue itemCount equals: 3.

	self assert: queue nextOrNil priority equals: 7.
	self assert: queue size equals: 1.
	self assert: queue itemCount equals: 2.

	self assert: queue nextOrNil priority equals: 8.
	self assert: queue size equals: 0.
	self assert: queue itemCount equals: 1.

	self assert: queue nextOrNil isNil.
	self assert: queue size equals: 0.
	self assert: queue itemCount equals: 1.

]

{ #category : #tests }
AtomicSharedPriorityQueueTest >> testNextIfNoneOrdered [

	| queue |

	"Test removing first element"
	queue := AtomicSharedPriorityQueue new.
	queue
		nextPut: (SharedPriorityQueueTestEntry priority: 0);
		nextPut: (SharedPriorityQueueTestEntry priority: 1);
		nextPut: (SharedPriorityQueueTestEntry priority: 2);
		nextPut: (SharedPriorityQueueTestEntry priority: 3);
		nextPut: (SharedPriorityQueueTestEntry priority: 4);
		nextPut: (SharedPriorityQueueTestEntry priority: 5).

	self assert: queue nextOrNil priority equals: 0.
	self assert: queue size equals: 5.
	self assert: queue itemCount equals: 5.

	self assert: queue nextOrNil priority equals: 1.
	self assert: queue size equals: 4.
	self assert: queue itemCount equals: 4.

	self assert: queue nextOrNil priority equals: 2.
	self assert: queue size equals: 3.
	self assert: queue itemCount equals: 3.

	self assert: queue nextOrNil priority equals: 3.
	self assert: queue size equals: 2.
	self assert: queue itemCount equals: 2.

	self assert: queue nextOrNil priority equals: 4.
	self assert: queue size equals: 1.
	self assert: queue itemCount equals: 1.

	self assert: queue nextOrNil priority equals: 5.
	self assert: queue size equals: 0.
	self assert: queue itemCount equals: 1.

	self assert: queue nextOrNil isNil.
	self assert: queue size equals: 0.
	self assert: queue itemCount equals: 1.

]
