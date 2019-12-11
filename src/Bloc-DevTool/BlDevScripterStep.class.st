Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'state',
		'label'
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

{ #category : #state }
BlDevScripterStep >> haltHere [
	state := BlDevScripterStepState haltHere
]

{ #category : #initialization }
BlDevScripterStep >> initialize [
	super initialize.
	state := BlDevScripterStepState ready.
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

{ #category : #state }
BlDevScripterStep >> stateColor [
	^ state color
]

{ #category : #state }
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
