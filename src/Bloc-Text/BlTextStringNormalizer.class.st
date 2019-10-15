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

	^ self processLineEndings: aString
]

{ #category : #accessing }
BlTextStringNormalizer >> processLineEndings: aString [
	| theLineEndings |
	
	theLineEndings := (BlTextLineEnding allSubclasses collect: #uniqueInstance) sorted: [ :a :b | a size > b size ].
	
	^ Array streamContents: [ :aStream |
		| aCurrentCharacter aNextCharacter aCurrentIndex aStringLength |
		
		aCurrentCharacter := Character null.
		aNextCharacter := Character null.
		aCurrentIndex := 1.
		aStringLength := aString size.
		
		[ aCurrentIndex <= aStringLength ]
			whileTrue: [
				aCurrentCharacter := aString at: aCurrentIndex.
				aNextCharacter := aCurrentIndex < aStringLength
					ifTrue: [ aString at: aCurrentIndex + 1 ]
					ifFalse: [ Character null ].
				
				theLineEndings
					detect: [ :eachLineEnding | eachLineEnding matches: aCurrentCharacter and: aNextCharacter ]
					ifFound: [ :aLineEnding |
						aStream nextPut: aLineEnding.
						aCurrentIndex := aCurrentIndex + aLineEnding size ]
					ifNone: [
						aStream nextPut: aCurrentCharacter.
						aCurrentIndex := aCurrentIndex + 1 ] ] ]
]
