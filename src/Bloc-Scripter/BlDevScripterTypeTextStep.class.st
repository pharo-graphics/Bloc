Class {
	#name : #BlDevScripterTypeTextStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterTypeTextStep >> defaultLabel [
	^ self text 
		ifNotNil: [ :aString | 'Type: ', aString asString ]
		ifNil: [ self className ]
]

{ #category : #actions }
BlDevScripterTypeTextStep >> playOn: aScripter [
	| aTarget anInputEvent |

	aTarget := self target findTargetStartingInScripter: aScripter.

	anInputEvent := BlTextInputEvent new
		text: self text.

	BlOSpace
		simulateEvent: anInputEvent
		on: aTarget.

	aScripter pulse.
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> text [
	<return: #String>
	^ text
]

{ #category : #accessing }
BlDevScripterTypeTextStep >> text: aStringOrChar [
	self 
		assert: [ aStringOrChar isString or: [ aStringOrChar isCharacter ] ]
		description: [ 'Text must be a string or character' ].
	text := aStringOrChar asString
]
