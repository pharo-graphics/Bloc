Class {
	#name : #BlGenerationText,
	#superclass : #BlWrappedText,
	#instVars : [
		'previousGeneration'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlGenerationText class >> fromText: aBrText [
	^ self basicNew
		initialize;
		initialize: aBrText copy
		with: aBrText generation
]

{ #category : #'text - copying' }
BlGenerationText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self text generation
]

{ #category : #initialization }
BlGenerationText >> initialize: aBrText with: aPreviousGeneration [

	previousGeneration := aPreviousGeneration.
	text := aBrText
]

{ #category : #testing }
BlGenerationText >> isNextGenerationOf: aBlText [
	^ self previousGeneration == aBlText generation
]

{ #category : #accessing }
BlGenerationText >> previousGeneration [
	<return: #Object>

	^ previousGeneration
]
