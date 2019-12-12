Class {
	#name : #BlDevScripterStepProperties,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'Bloc-DevTool-Scripter-UI'
}

{ #category : #adding }
BlDevScripterStepProperties >> add: aProperty [
	properties add: aProperty
]

{ #category : #adding }
BlDevScripterStepProperties >> addScreenshotForm: aForm [
	self add: (BlDevScripterStepScreenshot new form: aForm)
]

{ #category : #accessing }
BlDevScripterStepProperties >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties 
		detect: [ :eachProperty | eachProperty isScreenshot ]
		ifFound: [ :aScreenshot | aScreenshot gtScreenshotFor: aView ]
		ifNone: [ aView empty ]
]

{ #category : #initialization }
BlDevScripterStepProperties >> initialize [
	super initialize.
	properties := OrderedCollection new.
]

{ #category : #accessing }
BlDevScripterStepProperties >> properties [
	^ properties
]
