Class {
	#name : 'BlDevScripterStep',
	#superclass : 'Object',
	#instVars : [
		'state',
		'label',
		'properties'
	],
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing - properties' }
BlDevScripterStep >> addScreenshotForm: aForm [
	self properties addScreenshotForm: aForm
]

{ #category : 'accessing' }
BlDevScripterStep >> defaultLabel [
	^ 'Step'
]

{ #category : 'private - accessing' }
BlDevScripterStep >> getMousePositionIn: aScripter [
	^ (aScripter userData includesKey: #mousePosition)
		ifTrue: [ aScripter userData at: #mousePosition ]
		ifFalse: [ 0.0@0.0 ]
]

{ #category : 'accessing - state' }
BlDevScripterStep >> haltHere [
	state := BlDevScripterStepState haltHere
]

{ #category : 'testing' }
BlDevScripterStep >> hasCustomLabel [
	<return: #Boolean>
	^ label isNotNil
]

{ #category : 'private - accessing' }
BlDevScripterStep >> hasMousePositionIn: aScripter [
	^ aScripter userData includesKey: #mousePosition
]

{ #category : 'initialization' }
BlDevScripterStep >> initialize [
	super initialize.
	state := BlDevScripterStepState ready.
	properties := BlDevScripterStepProperties new.
]

{ #category : 'accessing - state' }
BlDevScripterStep >> isHaltState [
	<return: #Boolean>
	^ state isHalt
]

{ #category : 'testing' }
BlDevScripterStep >> isRootStep [
	^ false
]

{ #category : 'accessing' }
BlDevScripterStep >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : 'accessing' }
BlDevScripterStep >> label: anObject [
	label := anObject
]

{ #category : 'actions' }
BlDevScripterStep >> playOn: aScripter [
	
]

{ #category : 'actions' }
BlDevScripterStep >> playOnExecutor: anExecutor [ 
	self playOn: anExecutor scripter
]

{ #category : 'printing' }
BlDevScripterStep >> printOn: aStream [
	aStream nextPutAll: self label
]

{ #category : 'accessing - properties' }
BlDevScripterStep >> properties [
	<return: #BlDevScripterStepProperties>
	^ properties
]

{ #category : 'accessing' }
BlDevScripterStep >> realTarget [
	<return: #BlDevScripterTarget>
	^ self target
]

{ #category : 'accessing - reference' }
BlDevScripterStep >> reference [
	<return: #BlDevScripterReference>
	^ self properties reference
]

{ #category : 'accessing - reference' }
BlDevScripterStep >> reference: aBlDevScripterReference [
	self properties reference: aBlDevScripterReference
]

{ #category : 'accessing - reference' }
BlDevScripterStep >> referenceHere [
	| aDefinition |
	aDefinition := thisContext stack second blocMethodDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
]

{ #category : 'accessing - reference' }
BlDevScripterStep >> referenceSender [
	| aDefinition |
	aDefinition := thisContext stack third blocMethodDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
]

{ #category : 'accessing - state' }
BlDevScripterStep >> setFailedExecution [
	state := BlDevScripterStepState failure.
]

{ #category : 'private - accessing' }
BlDevScripterStep >> setMousePosition: aPoint in: aScripter [
	aScripter userData at: #mousePosition put: aPoint
]

{ #category : 'accessing - state' }
BlDevScripterStep >> setSuccessExecution [
	state := BlDevScripterStepState success.
]

{ #category : 'accessing - state' }
BlDevScripterStep >> setUnderExecution [
	state := BlDevScripterStepState executing.
]

{ #category : 'actions' }
BlDevScripterStep >> startWithExecutor: anExecutor [
	anExecutor executeStep: self
]

{ #category : 'accessing' }
BlDevScripterStep >> state [
	<return: #BlDevScripterStepState>
	^ state
]

{ #category : 'accessing - state' }
BlDevScripterStep >> stateColor [
	^ state color
]

{ #category : 'accessing - state' }
BlDevScripterStep >> stateName [
	^ state name
]

{ #category : 'accessing' }
BlDevScripterStep >> steps [
	^ #()
]

{ #category : 'accessing' }
BlDevScripterStep >> target [
	^ BlDevScripterSelfEventTarget new
]

{ #category : 'testing' }
BlDevScripterStep >> wasExecuted [
	<return: #Boolean>
	^ state wasExecuted
]
