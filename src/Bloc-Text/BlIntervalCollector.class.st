"
I use a position finder (a `BlPositionFinder`) to search for all intervals satisfying my actual finder. I can typically be used to search for all position intervals of a substring within a text.

"
Class {
	#name : #BlIntervalCollector,
	#superclass : #BlTextOperator,
	#instVars : [
		'finder'
	],
	#category : 'Bloc-Text-Text-Operator'
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
BlIntervalCollector >> searchAll: aSubstring [
	self substring: aSubstring.
	^ Array streamContents: [ :stream | 
		  | idx |
		  [ (idx := self search) > 0 ] whileTrue: [ 
			  | nextIdx |
			  nextIdx := idx + aSubstring size - 1 min: finder text size.
			  stream nextPut: (Interval from: idx to: nextIdx).
			  nextIdx < finder text size ifTrue: [ 
				  finder startAtPosition: nextIdx + 1 ] ] ]
]

{ #category : #'api - processing' }
BlIntervalCollector >> searchAll: aSubstring excluding: anInterval [

	self pattern: [ :aText :aPosition | 
		(anInterval intersection:
			 (aPosition to: aPosition + aSubstring size - 1)) isEmpty and: [ 
			aSubstring = (aText
				 from: aPosition
				 to: (aPosition + aSubstring size - 1 min: aText size)) asString ] ].

	^ Array streamContents: [ :stream | 
		  | idx |
		  [ (idx := self search) > 0 ] whileTrue: [ 
			  | nextIdx |
			  nextIdx := idx + aSubstring size - 1 min: finder text size.
			  stream nextPut: (Interval from: idx to: nextIdx).
			  nextIdx < finder text size ifTrue: [ 
				  finder startAtPosition: nextIdx + 1 ] ] ]
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

{ #category : #accessing }
BlIntervalCollector >> text: aBlText [
	finder text: aBlText
]
