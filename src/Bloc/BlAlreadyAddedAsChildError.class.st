"
I am signalled when user tries to add an {{gtClass:BlElement}}, that is already added to some other element as its child, to some other element.

"
Class {
	#name : #BlAlreadyAddedAsChildError,
	#superclass : #Error,
	#instVars : [
		'element'
	],
	#category : #'Bloc-Basic-Errors'
}

{ #category : #'instance creation' }
BlAlreadyAddedAsChildError class >> element: anElement [
	^ self new element: anElement
]

{ #category : #accessing }
BlAlreadyAddedAsChildError >> description [
	^ 'Can not add child that is already added to another element!'
]

{ #category : #accessing }
BlAlreadyAddedAsChildError >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlAlreadyAddedAsChildError >> element: anElement [
	element := anElement
]
