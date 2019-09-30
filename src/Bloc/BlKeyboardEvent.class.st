Class {
	#name : #BlKeyboardEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'scanCode',
		'repeat'
	],
	#category : #'Bloc-Events'
}

{ #category : #initialization }
BlKeyboardEvent >> initialize [
	super initialize.
	repeat := 0.
]

{ #category : #testing }
BlKeyboardEvent >> isKeyboard [
	^ true
]

{ #category : #accessing }
BlKeyboardEvent >> repeat [
	^ repeat
]

{ #category : #accessing }
BlKeyboardEvent >> repeat: anObject [
	repeat := anObject
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
BlKeyboardEvent >> scanCode: anObject [
	scanCode := anObject
]
