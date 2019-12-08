Class {
	#name : #BlDevScriptTypeTextTask,
	#superclass : #BlDevScripterInteractionTask,
	#instVars : [
		'text'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScriptTypeTextTask >> label [
	^ self text 
		ifNotNil: [ :aString | 'Type: ', aString asString ]
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScriptTypeTextTask >> playOn: aScripter [
	| aTarget anInputEvent |
	aTarget := self target findTargetIn: aScripter element.
	anInputEvent := BlTextInputEvent new text: self text.
	BlSpace
		simulateEvent: anInputEvent
		on: aTarget.
	aScripter pulse.
]

{ #category : #accessing }
BlDevScriptTypeTextTask >> text [
	<return: #String>
	^ text
]

{ #category : #accessing }
BlDevScriptTypeTextTask >> text: aStringOrChar [
	self 
		assert: [ aStringOrChar isString or: [ aStringOrChar isCharacter ] ]
		description: [ 'Text must be a string or character' ].
	text := aStringOrChar asString
]
