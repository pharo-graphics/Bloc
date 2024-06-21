Class {
	#name : #BlDevScripterKeyboardStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'key'
	],
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyboardStep >> key [
	<return: #KeyboardKey>

	^ key
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> key: aKeyboardKey [

	key := aKeyboardKey
]
