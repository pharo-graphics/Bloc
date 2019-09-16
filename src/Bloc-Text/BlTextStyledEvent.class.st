Class {
	#name : #BlTextStyledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text',
		'afterAction'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlTextStyledEvent >> afterAction [
	^ afterAction ifNil: [ :aBrText :anEditor | "do nothing" ]
]

{ #category : #accessing }
BlTextStyledEvent >> afterAction: anObject [
	afterAction := anObject
]

{ #category : #accessing }
BlTextStyledEvent >> text [
	^ text
]

{ #category : #accessing }
BlTextStyledEvent >> text: anObject [
	text := anObject
]
