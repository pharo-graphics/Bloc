"
# Underline
I represent a text underline attribute.
I am used together with {{gtClass:BlText}} and {{gtClass:TBlTextStyleable}} to style text.

https://en.wikipedia.org/wiki/Underline

See {{gtClass:BlTextUnderlineAttributeExamples}} for examples

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
