"
I do style short text in the same active process and longer text in a background process.

I am used by ${class:BlTextStyler}$.
"
Class {
	#name : #BlTextStylerAsyncTask,
	#superclass : #BlTextStylerTask,
	#instVars : [
		'monitor',
		'backgroundProcess'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #styling }
BlTextStylerAsyncTask >> doInBackground: aBrText andAfterDo: aBlock [
	self styler doStyleInBackground: aBrText andAfterDo: aBlock
]

{ #category : #initialization }
BlTextStylerAsyncTask >> initialize [
	super initialize.
	backgroundProcess := nil.
	monitor := Monitor new.
]

{ #category : #styling }
BlTextStylerAsyncTask >> style: aBlText afterDo: aBlock [
	self terminateBackgroundStylingProcess.
	aBlText size > 200
		ifTrue: [ self styleInBackgroundProcess: aBlText andAfterDo: aBlock ]
		ifFalse: [ self styleInActiveProcess: aBlText andAferDo: aBlock ]
]

{ #category : #styling }
BlTextStylerAsyncTask >> styleInActiveProcess: aBlText andAferDo: aBlock [
	self styler doStyle: aBlText afterDo: aBlock
]

{ #category : #styling }
BlTextStylerAsyncTask >> styleInBackgroundProcess: aBrText andAfterDo: aBlock [

	monitor critical: [
		backgroundProcess := [ 
			self doInBackground: aBrText andAfterDo: aBlock 
		] forkAt: Processor userBackgroundPriority named: 'Text Styler Async Task' 
	]
]

{ #category : #private }
BlTextStylerAsyncTask >> terminateBackgroundStylingProcess [
	monitor critical: [
		backgroundProcess ifNotNil: [ :aProcess |
			aProcess terminate.
			backgroundProcess := nil ] ]
]
