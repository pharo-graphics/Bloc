Class {
	#name : #BlDevScripterTask,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #printing }
BlDevScripterTask >> gtDisplayOn: aStream [
	aStream nextPutAll: self label
]

{ #category : #'gt-extension' }
BlDevScripterTask >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tasks';
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #initialization }
BlDevScripterTask >> initialize [
	super initialize.
	state := BlDevScripterTaskState ready.
]

{ #category : #accessing }
BlDevScripterTask >> label [
	^ 'Task'
]

{ #category : #accessing }
BlDevScripterTask >> labelColor [
	^ state color
]

{ #category : #'gt-extension' }
BlDevScripterTask >> paintTreeWith: view [
	view nodes
		shape: [ :each | 
			BlTextElement new 
				zIndex: 10;
				background: Color white;
				constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
				text: (each gtDisplayString asRopedText foreground: each labelColor) ];
		with: (self withDeepCollect: #tasks).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #tasks.
	view layout custom: (GtGradNorthHierarchicalLayout new)
]

{ #category : #actions }
BlDevScripterTask >> playIndicatingStateOn: aScripter [
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
BlDevScripterTask >> playOn: aScripter [
	
]

{ #category : #accessing }
BlDevScripterTask >> tasks [
	^ #()
]
