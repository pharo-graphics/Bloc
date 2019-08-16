"
SharedPriorityUniqueQueue is a thread-safe that:

- retrieves items in priority order (0 is the highest priority).
- optionally filters items on addition by item identifier.

The priorities are assumed to change dynamically, so it is not practical to store a sorted list.  If a 0 priority item is found it is returned immediately, otherwise the entire queue is scanned looking for the highest priority item.

If multiple items are found with the same priority, the first is returned.

Currently no optimisations are done to handle large queues, so the performance will degrade linearly with queue size if there are few or no priority 0 items.

Entries must respond to the #taskPriority message with zero or positive number.

!!Public API and Key Messages

SharedPriorityUniqueQueue has the same public interface as SharedQueue.

 
!!Internal Representation and Key Implementation Points.


!!!Implementation Points

Some care is taken to ensure that the queue is not corrupted by some other process attempting to terminate the owner of the monitor.  This is done by increasing the process priority by wrapping the operation in #valueWithoutUserInterruption while queue modifications are made.
"
Class {
	#name : #SharedPriorityUniqueQueue,
	#superclass : #SharedQueue,
	#category : #'Bloc-TaskIt-Queue'
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
		^[ items removeFirst ] valueWithoutUserInterruption ].
	2 to: items size do: [ :i | | each |
		each := items at: i.
		each entryPriority < highestPriority ifTrue: [ 
			item := each.
			highestIndex := i.
			highestPriority := item entryPriority ].
		highestPriority <= 0 ifTrue: [ 
			[ items removeAtIndex: highestIndex ] valueWithoutUserInterruption .
			^item ] ].
	[ items removeAtIndex: highestIndex ] valueWithoutUserInterruption.
	^item
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> next [
	^monitor critical: [
		monitor waitWhile: [ items isEmpty ].
		self basicNext ]

]

{ #category : #accessing }
SharedPriorityUniqueQueue >> nextOrNil [
	^monitor critical: [
		items isEmpty ifTrue: [ nil ] ifFalse: [ self basicNext ] ]
]

{ #category : #accessing }
SharedPriorityUniqueQueue >> nextPut: anObject [

	^monitor critical: [ | result itemAdded |
		itemAdded := false.
		result := anObject entryIdentifier ifNotNil: [ :identifier |
			items detect: [ :each | each entryIdentifier = identifier ]
					ifFound: [ :existing | existing ]
					ifNone: [ [ itemAdded := true. items addLast: anObject ] valueWithoutUserInterruption ] ]
			ifNil: [ itemAdded := true. items addLast: anObject ].
		itemAdded ifTrue: [ monitor signal ].
		result ].

]
