"
WaitfreePriorityQueue is a thread-safe implementation of a priority queue with wait-free operations.

- Priority 0 is the highest priority.
- The priorities are assumed to change dynamically, so it is not practical to store a sorted list.  If a 0 priority item is found it is returned immediately, otherwise the entire queue is scanned looking for the highest priority item.
- If multiple items are found with the same priority, the first is returned.

Currently no optimisations are done to handle large queues, so the performance will degrade linearly with queue size if there are few or no priority 0 items.

Entries must respond to the #priority message with a zero or positive number.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AtomicSharedPriorityQueue,
	#superclass : #AtomicSharedQueue,
	#category : #'Bloc-TaskIt-Queue'
}

{ #category : #accessing }
AtomicSharedPriorityQueue >> next [ 

	| result |
	
	[ | keepWaiting | 
		keepWaiting := false. 
		[ result := [ self nextIfNone: [ keepWaiting := true ] ] valueUnpreemptively ]
			ensure: [ StringSignal emit: 'done' ].
		keepWaiting ] whileTrue: [ self waitForNewItems ].

	^ result

]

{ #category : #accessing }
AtomicSharedPriorityQueue >> nextIfNone: aBlock [
	"Attempt to fetch the next highest priority item from queue (0 = highest priority). 
	Evaluate a block if attempt is failed i.e. there is no items available or queue is locked by another process"

	| first item object previous highest highestPrevious |

	(first := dummy makeCircular) == dummy  ifTrue: [ 
		"queue is either empty or currently locked by other feeder,
		just give a quick answer that item not found"
		^ aBlock value ].

	"Remove any zombie objects from the start of the list"
	[ (object := first object) == dummy ] whileTrue: [
		first isCircular ifTrue: [ 
			self signalNoMoreItems. 
			dummy next: first. 
			^ aBlock value ].
		first := first next.
	].

	item := first.
	previous := highestPrevious := nil.
	highest := item.

	[
		object := item object.
		object == dummy ifTrue: [ 
			"Remove the object unless it is the last.
			This can't happen on the first iteration, so no need to check previous"
			item isCircular ifFalse: [ 
				previous next: item next ] ]
		ifFalse: [
			"If the priority is 0, we can return immediately"
			object taskPriority = 0 ifTrue: 
				[ item object: dummy.
				previous ifNotNil: [ 
					previous next: item next.
					dummy next: first ]
				ifNil: 
					[ dummy next: item next ].
				^ object ].
			object taskPriority < highest object taskPriority ifTrue: [ 
				highest := item.
				highestPrevious := previous ] ].

		item isCircular ifTrue: [
			"this was the last one, answer the highest priority found.
			If highest == item, make it a zombie, otherwise
			remove highest from the list"
			object := highest object.
			highest == item ifTrue: [ 
				item object: dummy.
				dummy next: first ]
			ifFalse: [ 
				highest object: dummy.
				highestPrevious ifNotNil: [ 
					highestPrevious next: highest next.
					dummy next: first ]
				ifNil: 
					[ dummy next: highest next ] ].
			^ object ].

		previous := item.
		item := item next.
	] repeat.
]

{ #category : #accessing }
AtomicSharedPriorityQueue >> nextOrNilSuchThat: aBlock [
	"Fetch an object from queue that satisfies aBlock, skipping (but not removing) any intermediate objects.
	If no object has been found, answer <nil> and leave me intact.
	
	NOTA BENE:  aBlock can contain a non-local return (^).
	Found item is removed from queue.

	If queue currently in the middle of extraction by other process, don't wait and return <nil> immediately"
	
	| item first previous object |

	self flag: 'Submit back to Pharo WaitfreeQueue>>nextOrNilSuchThat:'.

	(first := dummy makeCircular) == dummy  ifTrue: [ ^ nil ]. 

	"Remove any zombie objects from the start of the list"
	[ (object := first object) == dummy ] whileTrue: [
		first isCircular ifTrue: [ 
			self signalNoMoreItems. 
			dummy next: first. ^ nil ].
		first := first next.
	].

	previous := nil.
	item := first.
	"Iterate over the list searching for the requested entry and removing zombies.
	This assumes that the first item isn't a zombie (which is why they're removed above. Otherwise dummy next: would be set early."
	[
		object := item object.
		object == dummy ifTrue: [ 
			"Remove the object unless it is the last.
			This can't happen on the first iteration, so no need to check previous"
			item isCircular ifFalse: [ 
				previous next: item next ] ]
		ifFalse: [
			( [ aBlock value: object ] ifCurtailed: [ dummy next: first ] ) ifTrue: [
				item object: dummy.
				previous ifNotNil: [ 
					previous next: item next.
					dummy next: first ]
				ifNil: 
					[ dummy next: item next ].
				^ object ]
			ifFalse:
				[ previous := item ] ].
	
		item isCircular ifTrue: [
			"this was the last one"
			dummy next: first.
			^ nil
			].

		item := item next.
	] repeat.
	
]
