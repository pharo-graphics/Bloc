"
A DragItem encapsulate a BlElement being dragged, to allow customisation of its appaerance, or specify its domain object. 
"
Class {
	#name : #BlDragItem,
	#superclass : #Object,
	#instVars : [
		'draggedElementStencil',
		'sourceElement',
		'domainObject',
		'draggedElement'
	],
	#category : #'Bloc-DragNDrop-core'
}

{ #category : #'as yet unclassified' }
BlDragItem >> createDraggedElement [
	<return: #BlElement>

"	^ draggedElementStencil
		dragItem: self;
		build"
		^self
]

{ #category : #accessing }
BlDragItem >> domainObject [
	^ domainObject
]

{ #category : #accessing }
BlDragItem >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #accessing }
BlDragItem >> draggedElement [
	^ draggedElement ifNil: [ draggedElement := self createDraggedElement ]
]

{ #category : #initialization }
BlDragItem >> initialize [
	super initialize.

	"draggedElementStencil := BlDragItemStencil new"
]

{ #category : #'as yet unclassified' }
BlDragItem >> previewElement [
	^ self draggedElement
]

{ #category : #accessing }
BlDragItem >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BlDragItem >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #'as yet unclassified' }
BlDragItem >> stencil [
	^ draggedElementStencil
]

{ #category : #accessing }
BlDragItem >> stencil: aBlDragItemStencil [
	"draggedElementStencil := aBlDragItemStencil asStencilBuilder: BlDragItemStencil"
	draggedElementStencil := aBlDragItemStencil
]
