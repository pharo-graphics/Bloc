"
I represent a line ending for a specific platform
"
Class {
	#name : #BlTextLineEnding,
	#superclass : #Object,
	#instVars : [
		'size'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #cleanup }
BlTextLineEnding class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlTextLineEnding class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
BlTextLineEnding >> asCharacter [
	"Return a Character that represents a Pharo-default line ending"
	<return: #Character>
	
	^ Character cr
]

{ #category : #converting }
BlTextLineEnding >> asString [
	<return: #String>

	^ self subclassResponsibility
]

{ #category : #testing }
BlTextLineEnding >> isLineBreak [
	^ true
]

{ #category : #testing }
BlTextLineEnding >> matches: aCurrentCharacter and: aNextCharacter [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #converting }
BlTextLineEnding >> size [
	<return: #Number>

	^ size ifNil: [ size := self asString size ]
]
