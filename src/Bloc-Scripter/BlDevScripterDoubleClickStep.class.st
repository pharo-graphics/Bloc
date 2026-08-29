Class {
	#name : #BlDevScripterDoubleClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterDoubleClickStep >> defaultLabel [
	^ 'Double Click'
]

{ #category : #actions }
BlDevScripterDoubleClickStep >> playOn: aScripter [
	| targetElement |
	targetElement := self target findTargetStartingInScripter: aScripter.
	self
		setMousePosition: targetElement eventSimulator doubleClick
		in: aScripter.
	aScripter settle
]
