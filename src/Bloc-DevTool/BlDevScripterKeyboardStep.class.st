Class {
	#name : #BlDevScripterKeyboardStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'key'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyboardStep >> key [
	<return: #BlKeyboardKey>

	^ key
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> key: aBlKeyboardKey [
	key := aBlKeyboardKey
]
