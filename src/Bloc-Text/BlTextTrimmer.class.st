Class {
	#name : 'BlTextTrimmer',
	#superclass : 'BlTextOperator',
	#instVars : [
		'leftTrimPatterns',
		'rightTrimPatterns'
	],
	#category : 'Bloc-Text-Text-Operator'
}

{ #category : 'api - configuration' }
BlTextTrimmer >> both: anOneArgBlock [
	self left: anOneArgBlock.
	self right: anOneArgBlock.
]

{ #category : 'api - configuration' }
BlTextTrimmer >> bothLineBreaks [
	self leftLineBreaks; rightLineBreaks.
]

{ #category : 'api - configuration' }
BlTextTrimmer >> bothSeparators [
	self leftSeparators; rightSeparators.
]

{ #category : 'initialization' }
BlTextTrimmer >> initialize [
	super initialize.
	leftTrimPatterns := OrderedCollection new.
	rightTrimPatterns := OrderedCollection new.
]

{ #category : 'api - configuration' }
BlTextTrimmer >> left: anOneArgBlock [
	self 
		assert: [ anOneArgBlock notNil ]
		description: [ 'Left trimming block must be non-nil' ].
	leftTrimPatterns add: anOneArgBlock
]

{ #category : 'api - configuration' }
BlTextTrimmer >> leftLineBreaks [
	self left: [ :aCharacter | aCharacter isLineBreak ]
]

{ #category : 'api - configuration' }
BlTextTrimmer >> leftSeparators [
	self left: [ :aCharacter | aCharacter isSeparator ]
]

{ #category : 'api - configuration' }
BlTextTrimmer >> right: anOneArgBlock [
	self 
		assert: [ anOneArgBlock notNil ]
		description: [ 'Right trimming block must be non-nil' ].
	rightTrimPatterns add: anOneArgBlock
]

{ #category : 'api - configuration' }
BlTextTrimmer >> rightLineBreaks [
	self right: [ :aCharacter | aCharacter isLineBreak ]
]

{ #category : 'api - configuration' }
BlTextTrimmer >> rightSeparators [
	self right: [ :aCharacter | aCharacter isSeparator ]
]

{ #category : 'api - processing' }
BlTextTrimmer >> trim [
	| left right |

	left := 1.
	right := self text size.

	[ left <= right and: [ leftTrimPatterns anySatisfy: [ :eachPattern | 
			eachPattern value: (self text at: left) ] ] ]
		whileTrue: [ left := left + 1 ].
		
	[ left <= right and: [ rightTrimPatterns anySatisfy: [ :eachPattern | 
			eachPattern value: (self text at: right) ] ] ]
		whileTrue: [ right := right - 1 ].
	right < self text size ifTrue: [
		self text delete: right + 1 to: self text size ].
	1 < left ifTrue: [ 
		self text delete: 1 to: left - 1 ].
]

{ #category : 'api - processing' }
BlTextTrimmer >> trimmed [
	"I return a new copy of the text trimmed according to the configuration"
	<return: #BlText>
	| left right |

	left := 1.
	right := self text size.

	[ left <= right and: [ leftTrimPatterns anySatisfy: [ :eachPattern | eachPattern value: (self text at: left) ] ] ]
		whileTrue: [ left := left + 1 ].

	[ left <= right and: [ rightTrimPatterns anySatisfy: [ :eachPattern | 
			eachPattern value: (self text at: right) ] ] ]
		whileTrue: [ right := right - 1 ].

	^ self text copyFrom: left to: right
]
