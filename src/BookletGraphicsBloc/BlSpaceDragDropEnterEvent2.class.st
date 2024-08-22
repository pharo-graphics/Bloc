Class {
	#name : #BlSpaceDragDropEnterEvent2,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'delegate',
		'position',
		'element'
	],
	#category : #'BookletGraphicsBloc-BlocDragNDrop'
}

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> delegate [

	^ delegate
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> delegate: anObject [

	delegate := anObject
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> element [

	^ element
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> element: anObject [

	element := anObject
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> position [

	^ position
]

{ #category : #accessing }
BlSpaceDragDropEnterEvent2 >> position: anObject [

	position := anObject
]

{ #category : #sending }
BlSpaceDragDropEnterEvent2 >> sendTo: anObject [
	anObject spaceDragDropEnterEvent: self
]
