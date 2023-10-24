"
I launch text styling process either by scheduling a process (if the element is attached to a space) or by enqueueing a task (if the element is not yet attached to a space).


"
Class {
	#name : 'BlTextStylerLauncher',
	#superclass : 'Object',
	#instVars : [
		'monitor',
		'isStylingRequested',
		'text',
		'backgroundProcess'
	],
	#classVars : [
		'MinTextSizeForStylingInBackground'
	],
	#category : 'Bloc-Text-Text-Styler',
	#package : 'Bloc-Text',
	#tag : 'Text-Styler'
}

{ #category : 'accessing' }
BlTextStylerLauncher class >> minTextSizeForStylingInBackground [
	^ MinTextSizeForStylingInBackground ifNil: [ MinTextSizeForStylingInBackground := 16000 ]
]

{ #category : 'accessing' }
BlTextStylerLauncher class >> minTextSizeForStylingInBackground: anInteger [
	MinTextSizeForStylingInBackground := anInteger
]

{ #category : 'accessing' }
BlTextStylerLauncher class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #minTextSizeForStylingInBackground)
		target: self;
		parent: #Bloc;
		default: 4000;
		description: 'Set the minimum text size imposed to allow background styling';
		label: 'Min text size for background styling'
]

{ #category : 'accessing' }
BlTextStylerLauncher >> backgroundProcess [ 

	^ backgroundProcess 
]

{ #category : 'private' }
BlTextStylerLauncher >> doStyleText: aText withStyler: aStyler [

	"Style a given text with the provided styler"

	aStyler style: aText
]

{ #category : 'private' }
BlTextStylerLauncher >> enqueueStyleText: aText withStyler: aStyler inElement: anElement [

	monitor critical: [ 
		| todo |
		aText ifEmpty: [ ^ self ].
		(aText = text and: [ isStylingRequested ]) ifTrue: [ ^ self ].
		text := aText.
		isStylingRequested := true.
		todo := aText size > self minTextSizeForStylingInBackground
			ifTrue: [ 
				backgroundProcess := self newProcessForStyling: aText withStyler: aStyler.
				[ self backgroundProcess ifNotNil: [ :bp | bp resume ] ] ]
			ifFalse: [ [ self doStyleText: aText withStyler: aStyler ] ].

		anElement enqueueTask: (BlTaskAction new action: [ 
				 todo value.
				 isStylingRequested := false ]) ]
]

{ #category : 'initialization' }
BlTextStylerLauncher >> initialize [

	super initialize.
	monitor := Monitor new.
	isStylingRequested := false
]

{ #category : 'accessing' }
BlTextStylerLauncher >> minTextSizeForStylingInBackground [

	^ self class minTextSizeForStylingInBackground
]

{ #category : 'private' }
BlTextStylerLauncher >> newProcessForStyling: aText withStyler: aStyler [

	| process |
	process := [ self doStyleText: aText withStyler: aStyler] newProcess.
	process priority: Processor userBackgroundPriority.
	process name: 'Text Styler Task'.
	^ process
]

{ #category : 'private' }
BlTextStylerLauncher >> scheduleStyleText: aText withStyler: aStyler [ 

	self terminateBackgroundStylingProcess.
	backgroundProcess := self newProcessForStyling: aText withStyler: aStyler.
	backgroundProcess resume
]

{ #category : 'public - styling' }
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

{ #category : 'private' }
BlTextStylerLauncher >> terminateBackgroundStylingProcess [

	backgroundProcess ifNotNil: [ 
		backgroundProcess terminate.
		backgroundProcess := nil ]
]
