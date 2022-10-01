"
I launch text styling process either by scheduling a process (if the element is attached to a space) or by enqueueing a task (if the element is not yet attached to a space).


"
Class {
	#name : #BlTextStylerLauncher,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'monitor',
		'isStylingRequested',
		'backgroundProcess'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #private }
BlTextStylerLauncher >> doStyleInElement: anElement [

	"Style a given text in a provided element and evaluate a Block with the styled text
	once completed. 
	Return styled text"

	| aStyledText |
	aStyledText := anElement styler style: anElement textSnapshot nextGeneration.

	"Dispatch the event in the UI thread"
	anElement enqueueTask: (BlTaskAction new action: [ anElement textStyled: aStyledText ]).

	^ aStyledText
]

{ #category : #private }
BlTextStylerLauncher >> enqueueStyleTextInElement: anElement [ 

	monitor critical: [ 
		isStylingRequested ifTrue: [ ^ self ].
		isStylingRequested := true.
		anElement enqueueTask: (BlTaskAction new action: [ 
				 self doStyleInElement: anElement.
				 isStylingRequested := false ]) ]
]

{ #category : #initialization }
BlTextStylerLauncher >> initialize [

	super initialize.
	monitor := Monitor new.
	isStylingRequested := false
]

{ #category : #private }
BlTextStylerLauncher >> scheduleStyleTextInElement: anElement [

	self terminateBackgroundStylingProcess.
	backgroundProcess := [ self doStyleInElement: anElement ]
		                     forkAt: Processor userBackgroundPriority
		                     named: 'Text Styler Task'
]

{ #category : #'public - styling' }
BlTextStylerLauncher >> styleTextInElement: anElement [ 

	" Take care to only schedule (with a fork) only if the editor is actually on the scene, otherwise, enqueue an editor task"

	monitor critical: [ 
		anElement isAttachedToSceneGraph
			ifTrue: [ self scheduleStyleTextInElement: anElement ]
			ifFalse: [ self enqueueStyleTextInElement: anElement ] ]
]

{ #category : #private }
BlTextStylerLauncher >> terminateBackgroundStylingProcess [

	backgroundProcess ifNotNil: [ 
		backgroundProcess terminate.
		backgroundProcess := nil ]
]
