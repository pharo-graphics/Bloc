Class {
	#name : #BlPositionFinder,
	#superclass : #BlTextOperator,
	#instVars : [
		'startIndex',
		'patterns',
		'stepLength'
	],
	#category : #'Bloc-Text-Text-Operator'
}

{ #category : #'api - configuration' }
BlPositionFinder >> character: aCharacter [
	self
		assert: [ aCharacter notNil ] 
		description: [ 'Searched character must be non-nil' ].
	self pattern: [ :eachCharacter | aCharacter = eachCharacter ]
]

{ #category : #initialization }
BlPositionFinder >> initialize [
	super initialize.
	patterns := OrderedCollection new.
	startIndex := 1.
	stepLength := 1.
]

{ #category : #private }
BlPositionFinder >> isCurrentIndexInsideOfText: aCurrentIndex [
	<return: #Boolean>
	^ aCurrentIndex > 0 and: [ aCurrentIndex <= self text size ]
]

{ #category : #'api - configuration' }
BlPositionFinder >> pattern: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ] 
		description: [ 'Pattern block must be non-nil' ].
	patterns add: anOneArgBlock
]

{ #category : #'api - configuration' }
BlPositionFinder >> reversed [
	self stepBy: stepLength negated
]

{ #category : #'api - processing' }
BlPositionFinder >> search [
	<return: #Integer>
	| aCurrentIndex |
	aCurrentIndex := startIndex.

	[ (self isCurrentIndexInsideOfText: aCurrentIndex) ] whileTrue: [ 
		(patterns anySatisfy: [ :eachPattern | 
			eachPattern value: (self text at: aCurrentIndex) ])
				ifTrue: [ 
					"A desired character was found"
					^ aCurrentIndex ].
		aCurrentIndex := aCurrentIndex + stepLength ].
	"No searched character was found"
	^ 0
]

{ #category : #'api - configuration' }
BlPositionFinder >> startAtEnd [
	self startAtPosition: self text size.
]

{ #category : #'api - configuration' }
BlPositionFinder >> startAtPosition: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Starting search position must be non-nil' ].
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Starting search position must be an integer' ].
	self 
		assert: [ anInteger > 0 and: [ anInteger <= self text size ] ] 
		description: [ 'Starting search position ', anInteger asString, 
			' is out of text bounds' ].
	startIndex := anInteger
]

{ #category : #'api - configuration' }
BlPositionFinder >> stepBy: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Step lenght must be non-nil' ].
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Step lenght must be an integer' ].
	self 
		assert: [ anInteger isZero not ] 
		description: [ 'Step lenght must be non-zero value' ].
	stepLength := anInteger.
]
