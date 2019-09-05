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
BlTextStylerAsyncTask >> doInBackground: aBrText afterDo: aBlock [
	self styler delay asDelay wait.
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
		ifTrue: [ self styleInBackgroundProcess: aBlText afterDo: aBlock ]
		ifFalse: [ self styleInActiveProcess: aBlText afterDo: aBlock ]
]

{ #category : #styling }
BlTextStylerAsyncTask >> styleInActiveProcess: aBlText afterDo: aBlock [
	self styler doStyle: aBlText afterDo: aBlock
]

{ #category : #styling }
BlTextStylerAsyncTask >> styleInBackgroundProcess: aBrText afterDo: aBlock [
	self styler view ifNil: [ 
		"The text cannot be styled in background if an element is not available"
		self styleInActiveProcess: aBrText afterDo: aBlock.
		^ self ].
	monitor critical: [
		backgroundProcess := [ 
			self doInBackground: aBrText afterDo: aBlock 
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
