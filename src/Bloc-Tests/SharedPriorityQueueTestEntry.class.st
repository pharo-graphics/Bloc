"
GtImageTestQueueEntry provides a dummy object that can be inserted in to GtImageLoadQueue for testing.



Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	priority:		<Object>


    Implementation Points
"
Class {
	#name : #SharedPriorityQueueTestEntry,
	#superclass : #Object,
	#instVars : [
		'priority',
		'entryIdentifier'
	],
	#category : #'Bloc-Tests-TaskIt'
}

{ #category : #'instance creation' }
SharedPriorityQueueTestEntry class >> priority: aNumber [

	^self new
		priority: aNumber;
		yourself
]

{ #category : #'instance creation' }
SharedPriorityQueueTestEntry class >> priority: aNumber identifier: anObject [

	^self new
		priority: aNumber;
		entryIdentifier: anObject;
		yourself
]

{ #category : #accessing }
SharedPriorityQueueTestEntry >> entryIdentifier [
	^ entryIdentifier
]

{ #category : #accessing }
SharedPriorityQueueTestEntry >> entryIdentifier: anObject [
	entryIdentifier := anObject
]

{ #category : #accessing }
SharedPriorityQueueTestEntry >> entryPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"
	^ priority
]

{ #category : #printing }
SharedPriorityQueueTestEntry >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< '(';
		print: priority;
		<< ', ';
		print: entryIdentifier;
		<< ')'
]

{ #category : #accessing }
SharedPriorityQueueTestEntry >> priority [
	^ priority
]

{ #category : #accessing }
SharedPriorityQueueTestEntry >> priority: anObject [
	priority := anObject
]
