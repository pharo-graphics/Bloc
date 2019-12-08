Class {
	#name : #BlDevScripterStep,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #actions }
BlDevScripterStep >> continueOn: aScripter [
	self wasExecuted ifTrue: [ ^ self ].
	self playIndicatingStateOn: aScripter.
]

{ #category : #printing }
BlDevScripterStep >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #'gt-extension' }
BlDevScripterStep >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Steps';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #initialization }
BlDevScripterStep >> initialize [
	super initialize.
	state := BlDevScripterTaskState ready.
]

{ #category : #accessing }
BlDevScripterStep >> label [
	^ 'Task'
]

{ #category : #accessing }
BlDevScripterStep >> labelColor [
	^ state color
]

{ #category : #'gt-extension' }
BlDevScripterStep >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			BlTextElement new 
				zIndex: 10;
				background: Color white;
				constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
				text: (each gtDisplayString asRopedText foreground: each labelColor) ];
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
	state := BlDevScripterTaskState executing.
	[ 
		self playOn: aScripter.
		state := BlDevScripterTaskState success.
	]
		on: Error 
		do: [ :anException | 
			state := BlDevScripterTaskState failure.
			anException pass ]
]

{ #category : #actions }
BlDevScripterStep >> playOn: aScripter [
	
]

{ #category : #accessing }
BlDevScripterStep >> steps [
	^ #()
]

{ #category : #testing }
BlDevScripterStep >> wasExecuted [
	<return: #Boolean>
	^ state wasExecuted
]
