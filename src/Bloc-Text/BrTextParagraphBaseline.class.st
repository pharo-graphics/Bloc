"
I represent a text paragraph baseline.
The baseline is the line upon which most letters ""sit"" and below which descenders extend.

(https://en.wikipedia.org/wiki/Baseline_(typography))
"
Class {
	#name : #BrTextParagraphBaseline,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Text-Text-Paragraph'
}

{ #category : #cleanup }
BrTextParagraphBaseline class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BrTextParagraphBaseline class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #baseline }
BrTextParagraphBaseline >> computedBaseline: aTextParagraph [
	<return: #Point>
	
	^ self subclassResponsibility
]
