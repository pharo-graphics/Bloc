Class {
	#name : #BlDevScripterSecondaryClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> defaultLabel [
	^ 'Secondary Click'
]

{ #category : #actions }
BlDevScripterSecondaryClickStep >> playOn: aScripter [
	| targetElement |
	targetElement := self target findTargetStartingInScripter: aScripter.
	self
		setMousePosition: targetElement eventSimulator secondaryClick
		in: aScripter.
	aScripter settle
]
