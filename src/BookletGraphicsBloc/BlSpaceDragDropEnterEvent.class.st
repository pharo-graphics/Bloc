Class {
	#name : #BlSpaceDragDropEnterEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position',
		'element'
	],
	#category : #'BookletGraphicsBloc-BlocDragNDrop'
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
