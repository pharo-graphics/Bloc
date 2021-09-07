Class {
	#name : 'BlPositionFinder',
	#superclass : 'BlTextOperator',
	#instVars : [
		'startIndex',
		'patterns',
		'stepLength'
	],
	#category : 'Bloc-Text-Text-Operator'
}

{ #category : 'api - configuration' }
BlPositionFinder >> caseInsensitiveSubstring: aString [
	| aLowerCaseString |
	self
		assert: [ aString notNil ] 
		description: [ 'Searched sub-string must be non-nil' ].
	aLowerCaseString := aString asLowercase.
	self pattern: [ :aText :aPosition | 
		aLowerCaseString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString asLowercase ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> caseSensitiveSubstring: aString [
	self
		assert: [ aString notNil ] 
		description: [ 'Searched sub-string must be non-nil' ].

	self pattern: [ :aText :aPosition | 
		aString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> character: aCharacter [
	self
		assert: [ aCharacter notNil ] 
		description: [ 'Searched character must be non-nil' ].
	self pattern: [ :aText :aPosition | 
		aCharacter = (aText at: aPosition) ]
]

{ #category : 'api - configuration' }
BlPositionFinder >> characters: aString [
	self
		assert: [ aString notNil ] 
		description: [ 'Searched characters must be non-nil' ].
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

{ #category : 'api - configuration' }
BlPositionFinder >> pattern: anOneArgBlock [
	self
		assert: [ anOneArgBlock notNil ] 
		description: [ 'Pattern block must be non-nil' ].
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
					"A desired position was found"
					^ aCurrentIndex ] ].
		aCurrentIndex := aCurrentIndex + stepLength ].
	"No pattern was satisfied"
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

{ #category : 'api - configuration' }
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

{ #category : 'api - configuration' }
BlPositionFinder >> substring: aString [
	self
		assert: [ aString notNil ] 
		description: [ 'Searched sub-string must be non-nil' ].
	self pattern: [ :aText :aPosition | 
		aString = (aText 
			from: aPosition 
			to: ((aPosition + aString size - 1) min: aText size)) asString ]
]
