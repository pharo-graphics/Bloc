Class {
	#name : #BlKeyboardEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'scanCode',
		'key'
	],
	#category : #'Bloc-Events'
}

{ #category : #converting }
BlKeyboardEvent >> asDictionaryForExport [
	^ super asDictionaryForExport
		at: #scanCode put: scanCode printString;
		at: #key put: key printString;
		yourself
]

{ #category : #testing }
BlKeyboardEvent >> isKeyboard [
	^ true
]

{ #category : #'key - accessing' }
BlKeyboardEvent >> key [
	<return: #KeyboardKey>

	^ key
]

{ #category : #'key - accessing' }
BlKeyboardEvent >> key: aKeyboardKey [

	key := aKeyboardKey
]

{ #category : #printing }
BlKeyboardEvent >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: 'key: ';
		print: key;
		nextPutAll: '; scan code: ';
		print: scanCode;
		nextPutAll: '; modifiers: ';
		print: modifiers;
		nextPut: $)
]

{ #category : #'key - accessing' }
BlKeyboardEvent >> scanCode [
	"A scancode (or scan code) is the data that most computer keyboards send to a computer to report which keys have been pressed.
	A number, or sequence of numbers, is assigned to each key on the keyboard.
	https://en.wikipedia.org/wiki/Scancode"
	<return: #Number>

	^ scanCode
]

{ #category : #'key - accessing' }
BlKeyboardEvent >> scanCode: aNumber [
	scanCode := aNumber
]
