Class {
	#name : #BlDevScripterMultipleCheckStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterCheckStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> defaultLabel [
	^ 'Checks'
]
