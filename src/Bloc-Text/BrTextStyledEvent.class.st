Class {
	#name : #BrTextStyledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'text'
	],
	#category : 'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BrTextStyledEvent >> text [
	^ text
]

{ #category : #accessing }
BrTextStyledEvent >> text: anObject [
	text := anObject
]
