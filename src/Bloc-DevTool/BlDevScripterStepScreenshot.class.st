Class {
	#name : #BlDevScripterStepScreenshot,
	#superclass : #BlDevScripterStepProperty,
	#instVars : [
		'form'
	],
	#category : #'Bloc-DevTool-Scripter-UI'
}

{ #category : #accessing }
BlDevScripterStepScreenshot >> form [
	^ form
]

{ #category : #accessing }
BlDevScripterStepScreenshot >> form: anObject [
	form := anObject
]

{ #category : #accessing }
BlDevScripterStepScreenshot >> gtScreenshotFor: aView [
	<gtView>
	self form ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Screenshot';
		stencil: [ self form asElement asScalableElement ]
]

{ #category : #testing }
BlDevScripterStepScreenshot >> isScreenshot [
	^ true
]
