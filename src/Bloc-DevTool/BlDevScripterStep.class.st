Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'state',
		'label',
		'reference'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterStep >> continueOn: aScripter [
	self wasExecuted ifTrue: [ ^ self ].
	self playIndicatingStateOn: aScripter.
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
BlDevScripterStep >> playIndicatingStateOn: aScripter [
	self 
		assert: [ state wasExecuted not ]
		description: [ 'I should not be executed twice' ].
	[ 
		state isHalt ifTrue: [ self halt ].
		state := BlDevScripterStepState executing.
		self playOn: aScripter.
		state := BlDevScripterStepState success.
	]
		on: Error 
		do: [ :anException | 
			state := BlDevScripterStepState failure.
			anException pass ]
]

{ #category : #actions }
BlDevScripterStep >> playOn: aScripter [
	
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
