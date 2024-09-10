"
Is sent by the space when an element is being dropped
"
Class {
	#name : #BlSpaceDragDropEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position',
		'element'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragDropEvent >> delegate [

	^ delegate
]

{ #category : #accessing }
BlSpaceDragDropEvent >> delegate: anObject [

	delegate := anObject
]

{ #category : #accessing }
BlSpaceDragDropEvent >> element [

	^ element
]

{ #category : #accessing }
BlSpaceDragDropEvent >> element: anObject [

	element := anObject
]

{ #category : #accessing }
BlSpaceDragDropEvent >> position [

	^ position
]

{ #category : #accessing }
BlSpaceDragDropEvent >> position: anObject [

	position := anObject
]

{ #category : #sending }
BlSpaceDragDropEvent >> sendTo: anObject [
	anObject spaceDragDropEvent: self
]
