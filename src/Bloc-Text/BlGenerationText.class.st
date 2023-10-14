Class {
	#name : 'BlGenerationText',
	#superclass : 'BlReadonlyText',
	#instVars : [
		'previousGeneration'
	],
	#category : 'Bloc-Text-Text',
	#package : 'Bloc-Text',
	#tag : 'Text'
}

{ #category : 'instance creation' }
BlGenerationText class >> fromText: aBlText [

	^ self basicNew
		initialize;
		initialize: aBlText copy
			with: aBlText generation;
		yourself
]

{ #category : 'text - copying' }
BlGenerationText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self text generation
]

{ #category : 'initialization' }
BlGenerationText >> initialize: aBlText with: aPreviousGeneration [

	previousGeneration := aPreviousGeneration.
	text := aBlText
]

{ #category : 'testing' }
BlGenerationText >> isNextGenerationOf: aBlText [
	^ self previousGeneration == aBlText generation
]

{ #category : 'accessing' }
BlGenerationText >> previousGeneration [
	<return: #Object>

	^ previousGeneration
]
