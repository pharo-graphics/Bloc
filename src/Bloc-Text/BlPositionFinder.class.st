"
I find a position in a text according to my configuration.
AS an example, I can be used to find the position of a substring within a text.

** warning ** not tested, not found any use and the semantic is not clear.
Tests are mandatory for this kind of toolkit class
"
Class {
	#name : 'BlPositionFinder',
	#superclass : 'BlTextOperator',
	#instVars : [
		'startIndex',
		'patterns',
		'stepLength'
	],
	#category : 'Bloc-Text-Text-Operator',
	#package : 'Bloc-Text',
	#tag : 'Text-Operator'
}

{ #category : 'api - configuration' }
BlPositionFinder >> caseInsensitiveSubstring: aString [
	| aLowerCaseString |
	aLowerCaseString := aString asLowercase.
	self pattern: [ :aText :aPosition | 
		aLowerCaseString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString asLowercase ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> caseSensitiveSubstring: aString [

	self pattern: [ :aText :aPosition | 
		aString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> character: aCharacter [

	self pattern: [ :aText :aPosition | 
		aCharacter = (aText at: aPosition) ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> characters: aString [

	aString do: [ :eachCharacter |
		self pattern: [ :aText :aPosition | 
			eachCharacter = (aText at: aPosition) ] ]
]

{ #category : 'initialization' }
BlPositionFinder >> initialize [
	super initialize.
	patterns := OrderedCollection new.
	startIndex := 1.
	stepLength := 1.
]

{ #category : 'private' }
BlPositionFinder >> isCurrentIndexInsideOfText: aCurrentIndex [
	<return: #Boolean>
	^ aCurrentIndex > 0 and: [ aCurrentIndex <= self text size ]
]

{ #category : 'api - processing' }
BlPositionFinder >> nextIndexFrom: aCurrentIndex [
		^ aCurrentIndex + stepLength
]

{ #category : 'api - configuration' }
BlPositionFinder >> pattern: anOneArgBlock [

	patterns add: anOneArgBlock
]

{ #category : 'api - configuration' }
BlPositionFinder >> reversed [
	self stepBy: stepLength negated
]

{ #category : 'api - processing' }
BlPositionFinder >> search [
	<return: #Integer>
	| aCurrentIndex |
	aCurrentIndex := startIndex.

	[ (self isCurrentIndexInsideOfText: aCurrentIndex) ] whileTrue: [ 
		patterns do: [ :eachPattern | 
			(eachPattern value: self text value: aCurrentIndex)
				ifTrue: [ 
					startIndex := self nextIndexFrom: aCurrentIndex.
					"A desired position was found"
					^ aCurrentIndex ] ].
		aCurrentIndex := self nextIndexFrom: aCurrentIndex ].
	"No pattern was satisfied"
	startIndex := self text size + 1.
	^ 0
]

{ #category : 'api - processing' }
BlPositionFinder >> searchClosest [
	<return: #Integer>
	| aStartIndex aForwardLocation aBackwardLocation |
	
	aStartIndex := startIndex.
	
	aForwardLocation := self search.
	aForwardLocation = aStartIndex
		ifTrue: [ ^ aForwardLocation ].
	
	aBackwardLocation := self
		startAtPosition: aStartIndex;
		reversed;
		search.
	self reversed.

	aBackwardLocation isZero
		ifTrue: [ ^ aForwardLocation ].
		
	aForwardLocation isZero
		ifTrue: [ ^ aBackwardLocation ].

	^ (aForwardLocation - aStartIndex) abs < (aBackwardLocation - aStartIndex) abs
		ifTrue: [ aForwardLocation ]
		ifFalse: [ aBackwardLocation ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> startAtEnd [
	self startAtPosition: self text size.
]

{ #category : 'api - configuration' }
BlPositionFinder >> startAtPosition: anInteger [

	self 
		assert: [ anInteger > 0 and: [ anInteger <= self text size ] ] 
		description: [ 'Starting search position ', anInteger asString, 
			' is out of text bounds' ].
	startIndex := anInteger
]

{ #category : 'accessing' }
BlPositionFinder >> startPosition [
	^ startIndex 
]

{ #category : 'api - configuration' }
BlPositionFinder >> stepBy: anInteger [
	
	anInteger isZero
		ifTrue: [ self error: 'Step length must be non-zero value' ].
	stepLength := anInteger.
]

{ #category : 'api - configuration' }
BlPositionFinder >> substring: aString [

	self pattern: [ :aText :aPosition | 
		aString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString ]
]
