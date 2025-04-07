Class {
	#name : #BlSingleKeyCombinationExamples,
	#superclass : #BlKeyCombinationExamplesTest,
	#category : #'Bloc-Examples-KeyBinding'
}

{ #category : #'examples - combination' }
BlSingleKeyCombinationExamples >> testArrowLeftCombination [

	<sampleInstance>
	| aKeyCombination |
	aKeyCombination := self arrowLeft asKeyCombination.
	self assert: (aKeyCombination isKindOf: KMSingleKeyCombination).
	self assert: aKeyCombination key equals: self arrowLeft.

	^ aKeyCombination
]

{ #category : #'examples - store' }
BlSingleKeyCombinationExamples >> testStoreArrowLeftCombination [

	<sampleInstance>
	| aKeyCombination aStoreString aRestoredKeyCombination |
	aKeyCombination := self testArrowLeftCombination.
	aStoreString := aKeyCombination storeString.

	self
		assert: aStoreString
		equals:
		'(KMSingleKeyCombination basicNew instVarAt: 1 put: (KeyboardKey basicNew instVarAt: 1 put: 65361; instVarAt: 2 put: #LEFT; yourself); yourself)'.

	aRestoredKeyCombination := Object compiler evaluate: aStoreString.
	self assert: aRestoredKeyCombination equals: aKeyCombination.

	^ aStoreString
]
