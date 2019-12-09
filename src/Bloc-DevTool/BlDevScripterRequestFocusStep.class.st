Class {
	#name : #BlDevScripterRequestFocusStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterRequestFocusStep >> label [
	^ 'Focus'
]

{ #category : #actions }
BlDevScripterRequestFocusStep >> playOn: aScripter [
	(self target findTargetIn: aScripter element) requestFocus.
	aScripter pulse
]
