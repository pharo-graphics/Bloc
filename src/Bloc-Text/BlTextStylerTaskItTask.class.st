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

{ #category : #private }
BlTextStylerTaskItTask >> commandNameFromText: aBrText [
	^ aBrText isEmpty
		ifTrue: [ '<empty query>' ]
		ifFalse: [ (aBrText from: 1 to: (aBrText size min: 20)) asString
				replace: [ :eachCharacter | 
					eachCharacter isLineBreak
						ifTrue: [ Character space ]
						ifFalse: [ eachCharacter ] ] ]
]

{ #category : #enumerating }
BlTextStylerTaskItTask >> doInBackground: aBrText afterDo: aBlock [
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
		ifTrue: [ self styleInBackgroundProcess: aBlText afterDo: aBlock ]
		ifFalse: [ self styleInActiveProcess: aBlText afterDo: aBlock ]
]

{ #category : #enumerating }
BlTextStylerTaskItTask >> styleInActiveProcess: aBlText afterDo: aBlock [
	self styler doStyle: aBlText afterDo: aBlock
]

{ #category : #enumerating }
BlTextStylerTaskItTask >> styleInBackgroundProcess: aBrText afterDo: aBlock [
	| aName |
	self styler view ifNil: [ 
		"The text cannot be styled in background if an element is not available"
		self styleInActiveProcess: aBrText afterDo: aBlock.
		^ self ].
	aName := self commandNameFromText: aBrText.
	monitor
		critical: [ command := [ self doInBackground: aBrText afterDo: aBlock ]
				asBlTktTerminableCommand.
			command name: 'Text Styler for ''' , aName , ''''.
			BlTktWorkerProvider highUICPUBoundPool schedule: command ]
]

{ #category : #private }
BlTextStylerTaskItTask >> terminateBackgroundStylingProcess [
	monitor critical: [
		command ifNotNil: [ :aCommand |
			aCommand terminate.
			command := nil ] ]
]
