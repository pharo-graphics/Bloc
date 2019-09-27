Class {
	#name : #BlDevScripterRequestFocusTask,
	#superclass : #BlDevScripterInteractionTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterRequestFocusTask >> label [
	^ 'Focus'
]

{ #category : #actions }
BlDevScripterRequestFocusTask >> playOn: aScripter [
	(self target findTargetIn: aScripter element) requestFocus.
	aScripter pulse
]
