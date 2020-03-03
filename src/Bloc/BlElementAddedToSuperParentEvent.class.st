"
Is sent by an element after it or any of its parents is added to another element as a child.

Note: I am not sent when element is re-attached!
"
Class {
	#name : #BlElementAddedToSuperParentEvent,
	#superclass : #BlElementEvent,
	#instVars : [
		'addedElement'
	],
	#category : #'Bloc-Events-Type-Element'
}

{ #category : #'api - enable / disable' }
BlElementAddedToSuperParentEvent class >> enableIn: anObject [
	anObject enableAddedToSuperParent
]

{ #category : #'api - enable / disable' }
BlElementAddedToSuperParentEvent class >> wantedIn: anObject [
	^ anObject wantsAddedToSuperParent
]

{ #category : #accessing }
BlElementAddedToSuperParentEvent >> addedElement [
	<return: #BlElement>

	^ addedElement
]

{ #category : #accessing }
BlElementAddedToSuperParentEvent >> addedElement: anElement [
	addedElement := anElement
]

{ #category : #sending }
BlElementAddedToSuperParentEvent >> sendTo: anObject [
	anObject elementAddedToSuperParentEvent: self
]
