"
I am sent between key down and key up events. I can be repeated while user holds a key pressed.
"
Class {
	#name : #BlKeystrokeEvent,
	#superclass : #BlKeyboardEvent,
	#instVars : [
		'char'
	],
	#category : #'Bloc-Events'
}

{ #category : #'key - accessing' }
BlKeystrokeEvent >> char [
	^ char
]

{ #category : #'key - accessing' }
BlKeystrokeEvent >> char: anObject [
	char := anObject
]

{ #category : #sending }
BlKeystrokeEvent >> sendTo: anObject [
	anObject keystrokeEvent: self
]
