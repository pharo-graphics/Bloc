"
I represent a text paragraph baseline.
The baseline is the line upon which most letters ""sit"" and below which descenders extend.

(https://en.wikipedia.org/wiki/Baseline_(typography))

"
Class {
	#name : #BlTextParagraphBaselineMeasurer,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Text-Paragraph'
}

{ #category : #cleanup }
BlTextParagraphBaselineMeasurer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlTextParagraphBaselineMeasurer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #baseline }
BlTextParagraphBaselineMeasurer >> computedBaseline: aTextParagraph [
	<return: #Point>
	
	^ self subclassResponsibility
]
