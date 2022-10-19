"
I launch text styling process either by scheduling a process (if the element is attached to a space) or by enqueueing a task (if the element is not yet attached to a space).


"
Class {
	#name : #BlTextStylerLauncher,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'isStylingRequested',
		'text',
		'backgroundProcess'
	],
	#classVars : [
		'MinTextSizeForStylingInBackground'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlTextStylerLauncher class >> minTextSizeForStylingInBackground [
	^ MinTextSizeForStylingInBackground ifNil: [ MinTextSizeForStylingInBackground := 4000 ]
]

{ #category : #accessing }
BlTextStylerLauncher class >> minTextSizeForStylingInBackground: anInteger [
	MinTextSizeForStylingInBackground := anInteger
]

{ #category : #accessing }
BlTextStylerLauncher class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #minTextSizeForStylingInBackground)
		target: self;
		parent: #Bloc;
		default: 4000;
		description: 'Set the minimum text size imposed to allow background styling';
		label: 'Min text size for background styling'
]

{ #category : #private }
BlTextStylerLauncher >> doStyleText: aText withStyler: aStyler [

	"Style a given text with the provided styler"

	aStyler style: aText
]

{ #category : #private }
BlTextStylerLauncher >> enqueueStyleText: aText withStyler: aStyler inElement: anElement [

	monitor critical: [ 
		aText ifEmpty: [ ^ self ].
		(aText = text and: [ isStylingRequested ]) ifTrue: [ ^ self ].
		text := aText.
		isStylingRequested := true.
		anElement enqueueTask: (BlTaskAction new action: [ 
				 self styleText: aText withStyler: aStyler inElement: anElement.
				 isStylingRequested := false ]) ]
]

{ #category : #initialization }
BlTextStylerLauncher >> initialize [

	super initialize.
	monitor := Monitor new.
	isStylingRequested := false
]

{ #category : #accessing }
BlTextStylerLauncher >> minTextSizeForStylingInBackground [

	^ self class minTextSizeForStylingInBackground
]

{ #category : #private }
BlTextStylerLauncher >> scheduleStyleText: aText withStyler: aStyler [ 

	self terminateBackgroundStylingProcess.
	backgroundProcess := [ self doStyleText: aText withStyler: aStyler]
		                     forkAt: Processor systemBackgroundPriority
		                     named: 'Text Styler Task'
]

{ #category : #'public - styling' }
BlTextStylerLauncher >> styleText: aText withStyler: aStyler inElement: anElement [

	" Take care to schedule (with a fork) only if the editor is actually on the scene, otherwise, enqueue an editor task"

	monitor critical: [ 
		anElement
			ifNotNil: [ 
				anElement isAttachedToSceneGraph
					ifTrue: [ 
						aText size > self minTextSizeForStylingInBackground
							ifTrue: [ self scheduleStyleText: aText withStyler: aStyler ]
							ifFalse: [ self doStyleText: aText withStyler: aStyler ] ]
					ifFalse: [ self enqueueStyleText: aText withStyler: aStyler inElement: anElement ] ]
			ifNil: [ 
				aText size > self minTextSizeForStylingInBackground
					ifTrue: [ self scheduleStyleText: aText withStyler: aStyler ]
					ifFalse: [ self doStyleText: aText withStyler: aStyler ] ] ]
]

{ #category : #private }
BlTextStylerLauncher >> terminateBackgroundStylingProcess [

	backgroundProcess ifNotNil: [ 
		backgroundProcess terminate.
		backgroundProcess := nil ]
]
