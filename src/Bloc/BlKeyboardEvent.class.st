Class {
	#name : #BlKeyboardEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'scanCode',
		'repeat'
	],
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlKeyboardEvent >> button [
	self shouldNotImplement
]

{ #category : #accessing }
BlKeyboardEvent >> button: anObject [
	self shouldNotImplement
]

{ #category : #accessing }
BlKeyboardEvent >> charCode [
	self 
		deprecated: 'Use charCode instead'
		on: 	'1 July 2017' 
		in: 'Pharo-6.0-60501-'.
	self halt
]

{ #category : #accessing }
BlKeyboardEvent >> charCode: anObject [ 
	self 
		deprecated: 'Use charCode: instead'
		on: 	'1 July 2017' 
		in: 'Pharo-6.0-60501-'.
	self halt
]

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
BlKeyboardEvent >> keyValue [
	self 
		deprecated: 'Use keyValue instead'
		on: 	'1 July 2017' 
		in: 'Pharo-6.0-60501-'.
	self halt
]

{ #category : #accessing }
BlKeyboardEvent >> keyValue: anObject [ 
	self 
		deprecated: 'Use key: instead'
		on: 	'1 July 2017' 
		in: 'Pharo-6.0-60501-'.
	self halt
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
