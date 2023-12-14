Class {
	#name : 'BlDevScripterMultipleCheckStep',
	#superclass : 'BlDevScripterCompositeStep',
	#traits : 'TBlDevScripterCheckStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterMultipleCheckStep >> defaultLabel [
	^ 'Checks'
]
