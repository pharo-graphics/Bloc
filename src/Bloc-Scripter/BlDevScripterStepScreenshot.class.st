Class {
	#name : 'BlDevScripterStepScreenshot',
	#superclass : 'BlDevScripterStepProperty',
	#instVars : [
		'form'
	],
	#category : 'Bloc-Scripter-Scripter-Properties',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Properties'
}

{ #category : 'accessing' }
BlDevScripterStepScreenshot >> form [
	^ form
]

{ #category : 'accessing' }
BlDevScripterStepScreenshot >> form: anObject [
	form := anObject
]

{ #category : 'testing' }
BlDevScripterStepScreenshot >> isScreenshot [
	^ true
]
