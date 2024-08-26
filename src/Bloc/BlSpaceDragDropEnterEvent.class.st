"
Is sent by the space when a dragged element enter the dropped area
"
Class {
	#name : #BlSpaceDragDropEnterEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position',
		'element'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> delegate [

	^ delegate
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> delegate: anObject [

	delegate := anObject
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> element [

	^ element
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> element: anObject [

	element := anObject
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> position [

	^ position
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent >> position: anObject [

	position := anObject
]

{ #category : #sending }
BlSpaceDragDropEnterEvent >> sendTo: anObject [
	anObject spaceDragDropEnterEvent: self
]
