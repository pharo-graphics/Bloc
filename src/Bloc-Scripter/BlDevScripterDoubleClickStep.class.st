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
	| targetElement eventSimulator |
	targetElement := self target findTargetStartingInScripter: aScripter.
	eventSimulator := targetElement eventSimulator.
	eventSimulator doubleClick.
	aScripter waitPendingWork
]
