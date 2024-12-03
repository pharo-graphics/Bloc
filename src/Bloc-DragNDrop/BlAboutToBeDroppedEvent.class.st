"
Event added to Bloc when the `BlSpaceDragDropEvent` has been fired to allow additional behavior during drag&drop operation
"
Class {
	#name : #BlAboutToBeDroppedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'dropTarget'
	],
	#category : #'Bloc-DragNDrop-core'
}

{ #category : #accessing }
BlAboutToBeDroppedEvent >> dropTarget [

	^ dropTarget
]

{ #category : #accessing }
BlAboutToBeDroppedEvent >> dropTarget: anObject [

	dropTarget := anObject
]
