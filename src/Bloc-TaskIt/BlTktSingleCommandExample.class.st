Class {
	#name : #BlTktSingleCommandExample,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #examples }
BlTktSingleCommandExample >> demonstrateSingleQueueOperation [
	<gtExample>
	"Demonstrate that adding two queue entries with the same identity results in a single entry on the queue (the first)"

	| entry1 entry2 entry3 queue addedEntry |

	queue := SharedPriorityUniqueQueue new.
	entry1 := [  ] asBlTktCommand asBlTktSingleCommand identifier: #single.
	addedEntry := queue nextPut: entry1.
	self
		assert: queue size 
		equals: 1.
	self assert: addedEntry == entry1.

	entry2 := [  ] asBlTktCommand.
	addedEntry := queue nextPut: entry2.
	self
		assert: queue size
		equals: 2.
	self assert: addedEntry == entry2.

	entry3 := [  ] asBlTktCommand asBlTktSingleCommand identifier: #single.
	addedEntry := queue nextPut: entry3.
	self 
		assert: queue size 
		equals: 2.
	self assert: addedEntry == entry1.

]
