Class {
	#name : #BlTextStyledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlTextStyledEvent >> text [
	^ text
]

{ #category : #accessing }
BlTextStyledEvent >> text: anObject [
	text := anObject
]
