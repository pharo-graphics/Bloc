"
I am signalled when user tries to add an `BlElement`, that is already added to some other element as its child, to some other element.
My message text names the element and the parent it already has.
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

{ #category : #accessing }
BlAlreadyAddedAsChildError >> messageText [
	"Say which element and which parent are involved, and how to move the element: the error is raised far from the code which added the child the first time.
	A text given when the error was signalled is kept"

	super messageText ifNotEmpty: [ :text | ^ text ].
	^ 'Can not add ' , element printString , ' as a child: it is already a child of ' , element parent printString , '. Remove it from its parent first with #removeFromParent'
]
