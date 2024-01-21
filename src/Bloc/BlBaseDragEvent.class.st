Class {
	#name : #BlBaseDragEvent,
	#superclass : #BlMouseEvent,
	#instVars : [
		'gestureSource',
		'gestureTarget',
		'dragboard',
		'startButtons'
	],
	#category : 'Bloc-Events'
}

{ #category : #converting }
BlBaseDragEvent >> asDragEvent [
	^ self
]

{ #category : #copying }
BlBaseDragEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	" Since the management of dnd relies on #isConsumed "
	anEvent isConsumed ifTrue: [ self consumed: true ]
]

{ #category : #accessing }
BlBaseDragEvent >> dragboard [
	^ dragboard
]

{ #category : #accessing }
BlBaseDragEvent >> dragboard: anObject [
	dragboard := anObject
]

{ #category : #accessing }
BlBaseDragEvent >> gestureSource [
	^ gestureSource
]

{ #category : #accessing }
BlBaseDragEvent >> gestureSource: anObject [
	gestureSource := anObject
]

{ #category : #accessing }
BlBaseDragEvent >> gestureTarget [
	^ gestureTarget
]

{ #category : #accessing }
BlBaseDragEvent >> gestureTarget: anObject [
	gestureTarget := anObject
]

{ #category : #testing }
BlBaseDragEvent >> isBaseDrag [
	^ true
]

{ #category : #testing }
BlBaseDragEvent >> isMiddleButtonDrag [
	^ startButtons = self class middleButton
]

{ #category : #testing }
BlBaseDragEvent >> isPrimaryButtonDrag [
	^ startButtons = self class primaryButton
]

{ #category : #testing }
BlBaseDragEvent >> isSecondaryButtonDrag [
	^ startButtons = self class secondaryButton
]

{ #category : #accessing }
BlBaseDragEvent >> startButtons [
	^ startButtons
]

{ #category : #accessing }
BlBaseDragEvent >> startButtons: anObject [
	startButtons := anObject
]
