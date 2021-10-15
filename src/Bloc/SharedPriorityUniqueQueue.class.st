"
SharedPriorityUniqueQueue is a thread-safe that:

- retrieves items in priority order (0 is the highest priority).
- optionally filters items on addition by item identifier.

The priorities are assumed to change dynamically, so it is not practical to store a sorted list.  If a 0 priority item is found it is returned immediately, otherwise the entire queue is scanned looking for the highest priority item.

If multiple items are found with the same priority, the first is returned.

Currently no optimisations are done to handle large queues, so the performance will degrade linearly with queue size if there are few or no priority 0 items.

Entries must respond to the #taskPriority message with zero or positive number.

## Public API and Key Messages

SharedPriorityUniqueQueue has the same public interface as SharedQueue.

 
## Internal Representation and Key Implementation Points.


### Implementation Points

Some care is taken to ensure that the queue is not corrupted by some other process attempting to terminate the owner of the monitor.  This is done by increasing the process priority by wrapping the operation in #valueWithoutUserInterruption while queue modifications are made.

"
Class {
	#name : #SharedPriorityUniqueQueue,
	#superclass : #SharedQueue,
	#category : #'Bloc-DataStructure - Priority Queue'
}

{ #category : #private }
SharedPriorityUniqueQueue >> basicNext [
	"Answer the next highest priority item.
	This should only be called within the monitor."

	| item highestIndex highestPriority |

	item := items first.
	highestIndex := 1.
	highestPriority := item entryPriority.
	highestPriority <= 0 ifTrue: [ 
		^items removeFirst ].
	2 to: items size do: [ :i | | each |
		each := items at: i.
		each entryPriority < highestPriority ifTrue: [ 
			item := each.
			highestIndex := i.
			highestPriority := item entryPriority ].
		highestPriority <= 0 ifTrue: [ 
			items removeAt: highestIndex.
			^item ] ].
	items removeAt: highestIndex.
	^item
]

{ #category : #private }
SharedPriorityUniqueQueue >> basicPeek [
	"Answer the next highest priority item.
	This should only be called within the monitor."

	| item highestIndex highestPriority |

	items isEmpty ifTrue: [ ^nil ].
	item := items first.
	highestIndex := 1.
	highestPriority := item entryPriority.
	highestPriority <= 0 ifTrue: [ 
		^items at: highestIndex ].
	2 to: items size do: [ :i | | each |
		each := items at: i.
		each entryPriority < highestPriority ifTrue: [ 
			item := each.
			highestIndex := i.
			highestPriority := item entryPriority ].
		highestPriority <= 0 ifTrue: [ 
			^item ] ].
	^item
]

{ #category : #flushing }
SharedPriorityUniqueQueue >> flush [ 
	"Remove from the queue all objects
	Ensure that the operation isn't terminated while within the monitor"

	^[ super flush ] valueNoContextSwitch
]

{ #category : #flushing }
SharedPriorityUniqueQueue >> flushAllSuchThat: aBlock [
	"Remove from the queue all objects that satisfy aBlock.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super flushAllSuchThat: aBlock ] valueNoContextSwitch 
]

{ #category : #size }
SharedPriorityUniqueQueue >> isEmpty [ 
	"Answer a boolean indicating whether the receiver has no entries.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super isEmpty ] valueNoContextSwitch 
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> itemArray [ 
	"Answer the number of entries in the receiver.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super itemArray ] valueNoContextSwitch
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> next [
	^[ monitor critical: [
		monitor waitWhile: [ items isEmpty ].
		self basicNext ] 
			] valueNoContextSwitch

]

{ #category : #accessing }
SharedPriorityUniqueQueue >> nextOrNil [
	^[ monitor critical: [
		items isEmpty ifTrue: [ nil ] ifFalse: [ self basicNext ] ]
			] valueNoContextSwitch
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> nextOrNilSuchThat: aBlock [
	"Answer the next object that satisfies aBlock, skipping any intermediate objects.
	If no object has been sent, answer <nil> and leave me intact.
	NOTA BENE:  aBlock MUST NOT contain a non-local return (^).
	Ensure that the operation isn't terminated while within the monitor"

	self
		assert: [ aBlock hasMethodReturn not ]
		description: [ 'Must not have a local return' ].

	^ [ super nextOrNilSuchThat: aBlock ] valueNoContextSwitch
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> nextPut: anObject [

	^[ monitor critical: [ | result itemAdded |
		itemAdded := false.
		result := anObject entryIdentifier 
			ifNotNil: [ :identifier |
				items detect: [ :each | each entryIdentifier = identifier ]
					ifFound: [ :existing | existing ]
					ifNone: [ [ itemAdded := true. items addLast: anObject ] valueNoContextSwitch ] ]
			ifNil: [ itemAdded := true. items addLast: anObject ].
		itemAdded ifTrue: [ monitor signal ].
		result ]
			] valueNoContextSwitch.

]

{ #category : #accessing }
SharedPriorityUniqueQueue >> peek [
	"Answer the object that was sent through the receiver first and has not 
	yet been received by anyone but do not remove it from the receiver. If 
	no object has been sent, return nil
	Ensure that the operation isn't terminated while within the monitor"

	^[ monitor critical: [ self basicPeek ] ] valueNoContextSwitch
]

{ #category : #copying }
SharedPriorityUniqueQueue >> postCopy [ 
	"Finish off the copy operation.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super postCopy ] valueNoContextSwitch
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> removeAll [ 
	"Empty the queue.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super removeAll ] valueNoContextSwitch
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> size [ 
	"Answer the number of entries in the receiver.
	Ensure that the operation isn't terminated while within the monitor"

	^[ super size ] valueNoContextSwitch
]
