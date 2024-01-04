Class {
	#name : #BlDevScripterMouseMoveOverStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMouseMoveOverStep >> defaultLabel [
	^ 'Mouse move over'
]

{ #category : #actions }
BlDevScripterMouseMoveOverStep >> playOn: aScripter [
	| aTarget anOldPositon aNewPosition |
	
	aTarget := self target findTargetStartingInScripter: aScripter.
	
	anOldPositon := (self hasMousePositionIn: aScripter)
		ifTrue: [ self getMousePositionIn: aScripter ]
		ifFalse: [ 0@0 ].

	aNewPosition := aTarget bounds inSpace center.
	
	self setMousePosition: aNewPosition in: aScripter.
	
	BlSpace simulateMouseMoveOn: aScripter element from: anOldPositon to: aNewPosition.
	aScripter pulse
]
