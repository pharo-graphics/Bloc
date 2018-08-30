Class {
	#name : #BlCursorElement,
	#superclass : #BlElement,
	#instVars : [
		'textPosition'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #initialization }
BlCursorElement >> initialize [
	super initialize.
	
	textPosition := 0
]

{ #category : #accessing }
BlCursorElement >> textPosition [
	^ textPosition
]

{ #category : #accessing }
BlCursorElement >> textPosition: anObject [
	textPosition := anObject
]
