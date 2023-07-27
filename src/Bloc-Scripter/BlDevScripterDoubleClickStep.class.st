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
	BlOSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter).
	BlOSpace simulateClickOn: (self target findTargetStartingInScripter: aScripter).
	aScripter pulse
]
