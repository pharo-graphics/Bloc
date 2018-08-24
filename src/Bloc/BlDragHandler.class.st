Class {
	#name : #BlDragHandler,
	#superclass : #BlElementEventListener,
	#instVars : [
		'delegate'
	],
	#category : 'Bloc-Utilities - Drag&Drop'
}

{ #category : #accessing }
BlDragHandler >> delegate [
	<return: #BlDragDelegate>

	^ delegate
]

{ #category : #accessing }
BlDragHandler >> delegate: aBlDragDelegate [
	delegate := aBlDragDelegate
]

{ #category : #'dnd handlers' }
BlDragHandler >> dragEndEvent: anEvent [
	anEvent currentTarget space dispatchEvent: (BlSpaceDragCancelEvent new delegate: delegate; position: anEvent position)
]

{ #category : #'dnd handlers' }
BlDragHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	delegate items: { BlDragItem new sourceElement: anEvent currentTarget }.

	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new delegate: delegate; position: anEvent position)
]

{ #category : #initialization }
BlDragHandler >> initialize [
	super initialize.

	delegate := BlDragDelegate new
]
