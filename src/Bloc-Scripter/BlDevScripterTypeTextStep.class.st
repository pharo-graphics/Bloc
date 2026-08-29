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
	| aTarget |

	aTarget := self target findTargetStartingInScripter: aScripter.
	aTarget eventSimulator textInput: self text.
	aScripter settle
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
