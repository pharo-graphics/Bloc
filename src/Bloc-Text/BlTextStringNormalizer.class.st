"
I process a given string and replace some characters with special items such as line endings.
I return an array of items (characters or other objects)
"
Class {
	#name : #BlTextStringNormalizer,
	#superclass : #Object,
	#category : #'Bloc-Text-Text'
}

{ #category : #accessing }
BlTextStringNormalizer >> process: aString [
	<return: #Array of: #Object>
	| theLogicalItems theLookaheadBuffer |
	
	theLogicalItems := ( {
			BlTextLineEndingMacClassic .
			BlTextLineEndingUnix .
			BlTextLineEndingWindows .
			BlTextTab
		} collect: #uniqueInstance) sorted: [ :a :b | a lookaheadSize > b lookaheadSize ].
		
	"allocate a buffer for the lookahead"
	theLookaheadBuffer := Array new: theLogicalItems first lookaheadSize withAll: Character null.
	
	^ Array streamContents: [ :aStream |
		| aCurrentIndex aStringLength |
	
		aCurrentIndex := 1.
		aStringLength := aString size.
		
		[ aCurrentIndex <= aStringLength ]
			whileTrue: [				
				"now we fill the lookahead buffer"
				1 to: theLookaheadBuffer size do: [ :aBufferIndex |
					| eachStringIndex |
					eachStringIndex := aCurrentIndex + (aBufferIndex - 1).
					theLookaheadBuffer at: aBufferIndex put: (eachStringIndex <= aStringLength
						ifTrue: [ aString at: eachStringIndex ]
						ifFalse: [ Character null ]) ].
				
				theLogicalItems
					detect: [ :eachLineEnding | eachLineEnding matches: theLookaheadBuffer ]
					ifFound: [ :aLineEnding |
						aStream nextPut: aLineEnding.
						aCurrentIndex := aCurrentIndex + aLineEnding lookaheadSize ]
					ifNone: [
						aStream nextPut: theLookaheadBuffer first.
						aCurrentIndex := aCurrentIndex + 1 ] ] ]
]
