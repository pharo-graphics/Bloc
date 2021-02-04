"
! Underline
I represent a text underline attribute.
I am used together with ${class:BlText}$ and ${class:TBlTextStyleable}$ to style text.

https://en.wikipedia.org/wiki/Underline

See ${class:BlTextUnderlineAttributeExamples}$ for examples
"
Class {
	#name : #BlTextUnderlineAttribute,
	#superclass : #BlTextDecorationAttribute,
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #testing }
BlTextUnderlineAttribute class >> isDeprecated [
	^ true
]

{ #category : #initialization }
BlTextUnderlineAttribute >> initialize [
	super initialize.
	
	decoration withUnderline
]
