"
I represent a model object and embody a drag preview and item provider
"
Class {
	#name : #BlDragItem,
	#superclass : #Object,
	#instVars : [
		'sourceElement',
		'previewElement'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'instace creation' }
BlDragItem >> createPreview [
	<return: #BlElement>
	
	^ BlElement new
		size: 20@20;
		background: Color blue
]

{ #category : #accessing }
BlDragItem >> previewElement [
	^ previewElement ifNil: [ previewElement := self createPreview ]
]

{ #category : #accessing }
BlDragItem >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #accessing }
BlDragItem >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BlDragItem >> sourceElement: anObject [
	sourceElement := anObject
]
