Class {
	#name : #BlDevScripterMouseMoveStep,
	#superclass : #BlDevScripterMouseStep,
	#instVars : [
		'delta'
	],
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseMoveStep >> by: aPoint [
	delta := aPoint
]

{ #category : #accessing }
BlDevScripterMouseMoveStep >> defaultLabel [
	^ 'Mouse move'
]

{ #category : #accessing }
BlDevScripterMouseMoveStep >> delta [
	^ delta
]

{ #category : #accessing }
BlDevScripterMouseMoveStep >> delta: anObject [
	delta := anObject
]

{ #category : #actions }
BlDevScripterMouseMoveStep >> initialize [
	super initialize.
	
	delta := 0@0
]

{ #category : #actions }
BlDevScripterMouseMoveStep >> playOn: aScripter [
	| anOldPositon aNewPosition |
	
	anOldPositon := (self hasMousePositionIn: aScripter)
		ifTrue: [ self getMousePositionIn: aScripter ]
		ifFalse: [ self delta ].

	aNewPosition := (self hasMousePositionIn: aScripter)
		ifTrue: [ anOldPositon + self delta ]
		ifFalse: [ anOldPositon ].
	
	self setMousePosition: aNewPosition in: aScripter.
	
	BlSpace simulateMouseMoveOn: aScripter element from: anOldPositon to: aNewPosition.
	aScripter pulse
]
