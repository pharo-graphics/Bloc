Class {
	#name : #BlDevScriptTypeTextStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'text'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScriptTypeTextStep >> label [
	^ self text 
		ifNotNil: [ :aString | 'Type: ', aString asString ]
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScriptTypeTextStep >> playOn: aScripter [
	| aTarget anInputEvent |
	aTarget := self target findTargetIn: aScripter element.
	anInputEvent := BlTextInputEvent new text: self text.
	BlSpace
		simulateEvent: anInputEvent
		on: aTarget.
	aScripter pulse.
]

{ #category : #accessing }
BlDevScriptTypeTextStep >> text [
	<return: #String>
	^ text
]

{ #category : #accessing }
BlDevScriptTypeTextStep >> text: aStringOrChar [
	self 
		assert: [ aStringOrChar isString or: [ aStringOrChar isCharacter ] ]
		description: [ 'Text must be a string or character' ].
	text := aStringOrChar asString
]
