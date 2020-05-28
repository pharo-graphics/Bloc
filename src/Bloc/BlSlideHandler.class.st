Class {
	#name : #BlSlideHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'originalPosition',
		'dragStartPosition'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'dnd handlers' }
BlSlideHandler >> dragEvent: anEvent [
	anEvent consumed: true.

	anEvent currentTarget children accountedByLayout do: [ :aChild |
		| aChildStartPosition aSlideDeltaInChild |
		
		aChildStartPosition := aChild userData
			at: #slideHandlerStartPosition
			ifAbsentPut: [ aChild position ].
		
		aSlideDeltaInChild := anEvent localPosition - dragStartPosition.
		
		aChild relocate: aChildStartPosition + aSlideDeltaInChild ]
]

{ #category : #'dnd handlers' }
BlSlideHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in local"
	dragStartPosition := anEvent localPosition.
	
	anEvent currentTarget children accountedByLayout
		do: [ :aChild | aChild userData at: #slideHandlerStartPosition put: aChild position ]
]
