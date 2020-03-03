Class {
	#name : #BlMultipleDragHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'delegate'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #accessing }
BlMultipleDragHandler >> delegate [
	^ delegate
]

{ #category : #accessing }
BlMultipleDragHandler >> delegate: anObject [
	delegate := anObject
]

{ #category : #'dnd handlers' }
BlMultipleDragHandler >> dragEndEvent: anEvent [
	anEvent currentTarget space dispatchEvent: (BlSpaceDragCancelEvent new delegate: delegate; position: anEvent position)
]

{ #category : #'dnd handlers' }
BlMultipleDragHandler >> dragStartEvent: anEvent [

"	theDraggedItems := anEvent currentTarget childrenCount timesCollect: [  BlDragItem new ].
	theDraggedItems
		ifEmpty: [ ^ self ].

	theDraggedItems
		with: anEvent currentTarget children
		do: [ :aDragItem :aSourceElement | aDragItem dragSession: (BlDragSession new sourceElement: aSourceElement)].
	anEvent consumed: true.

	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new dragItems: theDraggedItems)."
	
	anEvent consumed: true.

	delegate items: (anEvent currentTarget children collect: [ :aChild | BlDragItem new sourceElement: aChild ]).
	anEvent currentTarget space dispatchEvent: (BlSpaceDragLiftEvent new delegate: delegate; position: anEvent position)
]

{ #category : #initialization }
BlMultipleDragHandler >> initialize [
	super initialize.

	delegate := BlDragDelegate new
]
