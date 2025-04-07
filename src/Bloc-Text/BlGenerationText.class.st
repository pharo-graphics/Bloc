Class {
	#name : #BlGenerationText,
	#superclass : #BlReadonlyText,
	#instVars : [
		'previousGeneration'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #'instance creation' }
BlGenerationText class >> fromText: aBlText [

	^ self basicNew
		initialize;
		initialize: aBlText copy
			with: aBlText generation;
		yourself
]

{ #category : #initialization }
BlGenerationText >> initialize: aBlText with: aPreviousGeneration [

	previousGeneration := aPreviousGeneration.
	text := aBlText
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
