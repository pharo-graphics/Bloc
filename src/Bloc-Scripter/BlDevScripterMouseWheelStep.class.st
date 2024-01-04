Class {
	#name : #BlDevScripterMouseWheelStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'vector'
	],
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseWheelStep >> by: aPoint [
	self vector: aPoint asBlocVector
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> defaultLabel [
	^ 'Mouse wheel'
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> downBy: aNumber [
	self horizontallyBy: aNumber abs negated
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> horizontallyBy: aNumber [
	self vector: (BlVector x: 0 y: aNumber)
]

{ #category : #actions }
BlDevScripterMouseWheelStep >> initialize [
	super initialize.
	
	vector := (0@0) asBlocVector
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> leftBy: aNumber [
	self verticallyBy: aNumber abs negated
]

{ #category : #actions }
BlDevScripterMouseWheelStep >> playOn: aScripter [
	| aTarget |
	
	aTarget := self target findTargetStartingInScripter: aScripter.
	
	self
		setMousePosition: (BlSpace simulateMouseWheelOn: aTarget by: self vector)
		in: aScripter.

	aScripter pulse
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> rightBy: aNumber [
	self verticallyBy: aNumber abs
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> upBy: aNumber [
	self horizontallyBy: aNumber abs
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> vector [
	^ vector
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> vector: aBlVector [
	vector := aBlVector asBlocVector
]

{ #category : #accessing }
BlDevScripterMouseWheelStep >> verticallyBy: aNumber [
	self vector: (BlVector x: aNumber y: 0)
]
