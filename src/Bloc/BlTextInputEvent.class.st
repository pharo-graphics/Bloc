"
I am an event that it is fired when the user types some text.

I usually represent a single character, but I can be composed of multiples code points, specially for complex writing systems as Chinese.

"
Class {
	#name : #BlTextInputEvent,
	#superclass : #BlUIEvent,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlTextInputEvent >> isTextInput [
	^ true
]

{ #category : #sending }
BlTextInputEvent >> sendTo: anObject [
	anObject textInputEvent: self
]

{ #category : #accessing }
BlTextInputEvent >> text [
	^ text
]

{ #category : #accessing }
BlTextInputEvent >> text: anObject [
	text := anObject
]
