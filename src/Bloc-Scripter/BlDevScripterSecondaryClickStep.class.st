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
	self
		setMousePosition: ((BlEventSimulator forTarget: (self target findTargetStartingInScripter: aScripter)) simulateSecondaryClick)
		in: aScripter.
	aScripter pulse
]
