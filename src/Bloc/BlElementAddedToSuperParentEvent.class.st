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
	#category : #'Bloc-Event'
}

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
	anObject elementAddedToSuperParent: self
]
