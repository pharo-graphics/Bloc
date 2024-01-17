Class {
	#name : 'BlSingleKeyCombinationExamples',
	#superclass : 'BlKeyCombinationExamplesTest',
	#category : 'Bloc-Examples-KeyBinding',
	#package : 'Bloc-Examples',
	#tag : 'KeyBinding'
}

{ #category : 'examples - combination' }
BlSingleKeyCombinationExamples >> testArrowLeftCombination [

	<sampleInstance>
	| aKeyCombination |
	aKeyCombination := self arrowLeft asKeyCombination.
	self assert: (aKeyCombination isKindOf: BlSingleKeyCombination).
	self assert: aKeyCombination key equals: self arrowLeft.

	^ aKeyCombination
]

{ #category : 'examples - store' }
BlSingleKeyCombinationExamples >> testStoreArrowLeftCombination [

	<sampleInstance>
	| aKeyCombination aStoreString aRestoredKeyCombination |
	aKeyCombination := self testArrowLeftCombination.
	aStoreString := aKeyCombination storeString.

	self
		assert: aStoreString
		equals:
		'(BlKeyboardKey new setName: #ArrowLeft; setValue: nil) asKeyCombination'.

	aRestoredKeyCombination := Object evaluate: aStoreString.
	self assert: aRestoredKeyCombination equals: aKeyCombination.

	^ aStoreString
]
