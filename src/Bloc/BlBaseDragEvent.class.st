Class {
	#name : #BlBaseDragEvent,
	#superclass : #BlMouseEvent,
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

{ #category : #testing }
BlBaseDragEvent >> isBaseDrag [
	^ true
]
