Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'state',
		'label',
		'reference',
		'properties'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #'accessing - properties' }
BlDevScripterStep >> addScreenshotForm: aForm [
	self properties addScreenshotForm: aForm
]

{ #category : #accessing }
BlDevScripterStep >> defaultLabel [
	^ 'Step'
]

{ #category : #printing }
BlDevScripterStep >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #'gt-extension' }
BlDevScripterStep >> gtReferenceFor: aView [
	<gtView>
	self reference ifNil: [ ^ aView empty ].
	^ (self reference gtReferenceFor: aView)
		priority: 5
]

{ #category : #accessing }
BlDevScripterStep >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties gtScreenshotFor: aView
]

{ #category : #'gt-extension' }
BlDevScripterStep >> gtStepsMondrianTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Steps';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'gt-extension' }
BlDevScripterStep >> gtStepsTreeFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Steps In Tree';
		priority: 2.5;
		expandUpTo: 3;
		items: [ { self } ];
		children: [ :aStep | aStep steps ];
		column: 'Status' do: [ :aColumn | 
			aColumn 
				itemFormat: [ :aStep | aStep stateName asRopedText foreground: aStep stateColor ] ];
		column: 'Step' item: #label;
		column: 'Target' item: #target
]

{ #category : #'accessing - state' }
BlDevScripterStep >> haltHere [
	state := BlDevScripterStepState haltHere
]

{ #category : #initialization }
BlDevScripterStep >> initialize [
	super initialize.
	state := BlDevScripterStepState ready.
	reference := BlDevScripterReference null.
	properties := BlDevScripterStepProperties new.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> isHaltState [
	<return: #Boolean>
	^ state isHalt
]

{ #category : #accessing }
BlDevScripterStep >> label [
	^ label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlDevScripterStep >> label: anObject [
	label := anObject
]

{ #category : #'gt-extension' }
BlDevScripterStep >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			BlDevScripterStepElement newFromStep: each ];
		with: (self withDeepCollect: #steps).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #steps.
	view layout custom: (GtGradNorthHierarchicalLayout new)
]

{ #category : #actions }
BlDevScripterStep >> playOn: aScripter [
	
]

{ #category : #actions }
BlDevScripterStep >> playOnExecutor: anExecutor [ 
	self playOn: anExecutor scripter
]

{ #category : #'accessing - properties' }
BlDevScripterStep >> properties [
	<return: #BlDevScripterStepProperties>
	^ properties
]

{ #category : #accessing }
BlDevScripterStep >> realTarget [
	<return: #BlDevScripterTarget>
	^ self target
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> reference [
	<return: #BlDevScripterReference>
	^ reference
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> reference: aBlDevScripterReference [
	reference := aBlDevScripterReference
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceHere [
	| aDefinition |
	aDefinition := thisContext stack second method asRingDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
]

{ #category : #'accessing - reference' }
BlDevScripterStep >> referenceSender [
	| aDefinition |
	aDefinition := thisContext stack third method asRingDefinition.
	self reference: (BlDevScripterReference method: aDefinition).
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setFailedExecution [
	state := BlDevScripterStepState failure.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setSuccessExecution [
	state := BlDevScripterStepState success.
]

{ #category : #'accessing - state' }
BlDevScripterStep >> setUnderExecution [
	state := BlDevScripterStepState executing.
]

{ #category : #actions }
BlDevScripterStep >> startWithExecutor: anExecutor [
	anExecutor executeStep: self
]

{ #category : #accessing }
BlDevScripterStep >> state [
	<return: #BlDevScripterStepState>
	^ state
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateColor [
	^ state color
]

{ #category : #'accessing - state' }
BlDevScripterStep >> stateName [
	^ state name
]

{ #category : #accessing }
BlDevScripterStep >> steps [
	^ #()
]

{ #category : #accessing }
BlDevScripterStep >> target [
	^ BlDevScripterSelfEventTarget new
]

{ #category : #testing }
BlDevScripterStep >> wasExecuted [
	<return: #Boolean>
	^ state wasExecuted
]
