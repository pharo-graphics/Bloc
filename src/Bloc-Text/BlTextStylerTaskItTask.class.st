"
I do style short text in the same active process and longer text in a background process.
I use TaskIt (see ${class:BlTktWorkerProvider}$) to style in background.

I am used by ${class:BlTextStyler}$.
"
Class {
	#name : #BlTextStylerTaskItTask,
	#superclass : #BlTextStylerTask,
	#instVars : [
		'monitor',
		'command'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #enumerating }
BlTextStylerTaskItTask >> doInBackground: aBrText andAfterDo: aBlock [
	self styler doStyleInBackground: aBrText andAfterDo: aBlock
]

{ #category : #initialization }
BlTextStylerTaskItTask >> initialize [
	super initialize.
	command := nil.
	monitor := Monitor new.
]

{ #category : #styling }
BlTextStylerTaskItTask >> style: aBlText afterDo: aBlock [
	self terminateBackgroundStylingProcess.
	aBlText size > 200
		ifTrue: [ self styleInBackgroundProcess: aBlText andAfterDo: aBlock ]
		ifFalse: [ self styleInActiveProcess: aBlText andAferDo: aBlock ]
]

{ #category : #enumerating }
BlTextStylerTaskItTask >> styleInActiveProcess: aBlText andAferDo: aBlock [
	self styler doStyle: aBlText afterDo: aBlock
]

{ #category : #enumerating }
BlTextStylerTaskItTask >> styleInBackgroundProcess: aBrText andAfterDo: aBlock [

	monitor critical: [
		command := [ 
			self doInBackground: aBrText andAfterDo: aBlock 
		] asBlTktTerminableCommand.
		command name: 'Text Styler'.
		BlTktWorkerProvider highUICPUBoundPool schedule: command.
	]
]

{ #category : #private }
BlTextStylerTaskItTask >> terminateBackgroundStylingProcess [
	monitor critical: [
		command ifNotNil: [ :aCommand |
			aCommand terminate.
			command := nil ] ]
]
