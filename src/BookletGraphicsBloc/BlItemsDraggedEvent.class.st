Class {
	#name : #BlItemsDraggedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'items',
		'position',
		'offset',
		'dragContainer'
	],
	#category : #'BookletGraphicsBloc-BlocDragNDrop'
}

{ #category : #accessing }
BlItemsDraggedEvent >> dragContainer [

	^ dragContainer
]

{ #category : #accessing }
BlItemsDraggedEvent >> dragContainer: anObject [

	dragContainer := anObject
]

{ #category : #'as yet unclassified' }
BlItemsDraggedEvent >> dragContainerCenter [
	"Return a location of the center of the dragging container"
	<return: #Point>

	^ self position - self offset + (self dragContainer extent / 2.0)
]

{ #category : #accessing }
BlItemsDraggedEvent >> items [

	^ items
]

{ #category : #accessing }
BlItemsDraggedEvent >> items: anObject [

	items := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> offset [

	^ offset
]

{ #category : #accessing }
BlItemsDraggedEvent >> offset: anObject [

	offset := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> position [

	^ position
]

{ #category : #accessing }
BlItemsDraggedEvent >> position: anObject [

	position := anObject
]

{ #category : #sending }
BlItemsDraggedEvent >> sendTo: anObject [
	anObject itemsDraggedEvent: self
]
