Class {
	#name : #BlBaseDragEvent,
	#superclass : #BlMouseEvent,
	#instVars : [
		'gestureSource'
	],
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlBaseDragEvent >> asDragEvent [
	^ self
]

{ #category : #copying }
BlBaseDragEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	" Since the management of dnd relies on #isConsumed "
	anEvent isConsumed ifTrue: [ self consume ]
]

{ #category : #accessing }
BlBaseDragEvent >> gestureSource [

	^ gestureSource
]

{ #category : #accessing }
BlBaseDragEvent >> gestureSource: anObject [

	gestureSource := anObject
]

{ #category : #testing }
BlBaseDragEvent >> isBaseDrag [
	^ true
]
