"
I use a position finder (a `BlPositionFinder`) to search for all intervals satisfying my actual finder. I can typically be used to search for all position intervals of a substring within a text.

"
Class {
	#name : #BlIntervalCollector,
	#superclass : #BlTextOperator,
	#instVars : [
		'finder'
	],
	#category : #'Bloc-Text-Text-Operator'
}

{ #category : #'api - configuration' }
BlIntervalCollector >> caseInsensitiveSubstring: aString [
	finder caseInsensitiveSubstring: aString
]

{ #category : #'api - configuration' }
BlIntervalCollector >> caseSensitiveSubstring: aString [

	finder caseSensitiveSubstring: aString
]

{ #category : #'api - configuration' }
BlIntervalCollector >> character: aCharacter [

	finder character: aCharacter
]

{ #category : #'api - configuration' }
BlIntervalCollector >> characters: aString [

	finder characters: aString
]

{ #category : #initialization }
BlIntervalCollector >> initialize [
	super initialize.
	finder := BlPositionFinder new
]

{ #category : #'api - configuration' }
BlIntervalCollector >> pattern: anOneArgBlock [

	finder pattern: anOneArgBlock
]

{ #category : #'api - configuration' }
BlIntervalCollector >> reversed [
	finder reversed
]

{ #category : #'api - processing' }
BlIntervalCollector >> search [

	^ finder search
]

{ #category : #'api - processing' }
BlIntervalCollector >> searchAll [

	^ Array streamContents: [ :stream | 
		  | idx |
		  [ (idx := self search) > 0 ] whileTrue: [ 
			  | nextIdx storedIdx |
			  nextIdx := finder nextIndexFrom: idx.
			  storedIdx := nextIdx = 0
				               ifTrue: [ finder text size ]
				               ifFalse: [ nextIdx ].
			  stream nextPut: (Array with: idx with: storedIdx).
			  finder startAtPosition: nextIdx ] ]
]

{ #category : #'api - configuration' }
BlIntervalCollector >> startAtEnd [
	finder startAtEnd
]

{ #category : #'api - configuration' }
BlIntervalCollector >> startAtPosition: anInteger [

	finder startAtPosition: anInteger
]

{ #category : #'api - configuration' }
BlIntervalCollector >> stepBy: anInteger [
	
	finder stepBy: anInteger
]

{ #category : #'api - configuration' }
BlIntervalCollector >> substring: aString [

	finder substring: aString
]
